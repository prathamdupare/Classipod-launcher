import 'dart:async';

import 'package:classipod/core/navigation/routes.dart';
import 'package:classipod/core/services/audio_player_service.dart';
import 'package:classipod/core/widgets/display_list_tile.dart';
import 'package:classipod/features/custom_screen_elements/custom_screen.dart';
import 'package:classipod/features/menu/controller/split_screen_controller.dart';
import 'package:classipod/features/menu/models/main_menu_entry.dart';
import 'package:classipod/features/menu/models/split_screen_type.dart';
import 'package:classipod/features/menu/providers/main_menu_entries_provider.dart';
import 'package:classipod/features/status_bar/widgets/status_bar.dart';
import 'package:classipod/features/tutorial/controller/tutorial_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:installed_apps/installed_apps.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  final bool showTutorial;

  const MainMenuScreen({super.key, this.showTutorial = false});

  @override
  ConsumerState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen>
    with CustomScreen {
  @override
  String get routeName => Routes.menu.name;

  @override
  List<MainMenuEntry> get displayItems => ref.read(mainMenuEntriesProvider);

  @override
  void onMenuButtonPressed() {
    return;
  }

  @override
  Future<void> onSelectPressed() async {
    final menuEntries = displayItems;
    if (selectedDisplayItem >= menuEntries.length) {
      return;
    }
    await _selectEntry(menuEntries[selectedDisplayItem]);
  }

  Future<void> _selectEntry(MainMenuEntry menuEntry) async {
    setState(() => selectedDisplayItem = displayItems.indexOf(menuEntry));
    switch (menuEntry) {
      case PinnedAppEntry(appInfo: final appInfo):
        await InstalledApps.startApp(appInfo.packageName);
      case MainMenuActionEntry():
        await _runAction(menuEntry.action);
    }
  }

  Future<void> _runAction(MainMenuAction action) async {
    switch (action) {
      case MainMenuAction.music:
        context.goNamed(Routes.musicMenu.name);
        break;
      case MainMenuAction.apps:
        context.goNamed(Routes.apps.name);
        break;
      case MainMenuAction.nowPlaying:
        await _navigateToNowPlayingScreen();
        break;
      case MainMenuAction.settings:
        context.goNamed(Routes.settings.name);
        break;
      case MainMenuAction.shuffleSongs:
        await ref.read(audioPlayerServiceProvider.notifier).shuffleAllSongs();
        await _navigateToNowPlayingScreen();
        break;
    }
  }

  Future<void> _navigateToNowPlayingScreen() async {
    unawaited(ref.read(splitScreenViewControllerProvider).closeSplitView());
    await context.pushNamed(Routes.nowPlaying.name, extra: Routes.menu.name);
    unawaited(ref.read(splitScreenViewControllerProvider).openSplitView());
  }

  Future<void> _changeSplitScreenType() async {
    await Future.delayed(const Duration(milliseconds: 150));
    final menuEntries = displayItems;
    if (selectedDisplayItem >= menuEntries.length) {
      return;
    }
    final splitScreenController = ref.read(
      splitScreenControllerProvider.notifier,
    );
    switch (menuEntries[selectedDisplayItem]) {
      // A pinned app reuses the Apps preview rather than carrying its own
      // split screen state.
      case PinnedAppEntry():
        splitScreenController.changeSplitScreenType = SplitScreenType.apps;
      case MainMenuActionEntry(action: final action):
        switch (action) {
          case MainMenuAction.music:
            splitScreenController.changeSplitScreenType =
                SplitScreenType.albumArt;
            break;
          case MainMenuAction.apps:
            splitScreenController.changeSplitScreenType = SplitScreenType.apps;
            break;
          case MainMenuAction.settings:
            splitScreenController.changeSplitScreenType =
                SplitScreenType.settings;
            break;
          case MainMenuAction.shuffleSongs:
            splitScreenController.changeSplitScreenType =
                SplitScreenType.shuffle;
            break;
          case MainMenuAction.nowPlaying:
            splitScreenController.changeSplitScreenType =
                SplitScreenType.nowPlaying;
            break;
        }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tutorialControllerProvider.notifier).playMenuTutorial();
    });
  }

  @override
  void didUpdateWidget(covariant MainMenuScreen oldWidget) {
    if (widget.showTutorial) {
      ref.read(tutorialControllerProvider.notifier).playMenuTutorial();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final menuEntries = ref.watch(mainMenuEntriesProvider);

    // Unpinning an app shortens the list, so keep the highlight in range.
    if (selectedDisplayItem >= menuEntries.length) {
      selectedDisplayItem = menuEntries.length - 1;
    }

    unawaited(_changeSplitScreenType());
    if (!ref.read(splitScreenViewControllerProvider).isScreenVisible) {
      unawaited(ref.read(splitScreenViewControllerProvider).openSplitView());
    }

    return CupertinoPageScaffold(
      child: Column(
        children: [
          StatusBar(title: Routes.menu.title(context)),
          Expanded(
            child: CupertinoScrollbar(
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                itemCount: menuEntries.length,
                prototypeItem: const DisplayListTile(
                  text: '',
                  isSelected: false,
                ),
                itemBuilder: (context, index) {
                  return DisplayListTile(
                    key: ValueKey(menuEntries[index]),
                    text: menuEntries[index].title(context),
                    isSelected: selectedDisplayItem == index,
                    onTap: () async => _selectEntry(menuEntries[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

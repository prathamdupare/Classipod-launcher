import 'dart:async';

import 'package:classipod/core/extensions/build_context_extensions.dart';
import 'package:classipod/core/navigation/routes.dart';
import 'package:classipod/core/widgets/display_list_tile.dart';
import 'package:classipod/core/widgets/empty_state_widget.dart';
import 'package:classipod/features/apps/controllers/pinned_apps_controller.dart';
import 'package:classipod/features/apps/providers/installed_apps_provider.dart';
import 'package:classipod/features/custom_screen_elements/custom_screen.dart';
import 'package:classipod/features/status_bar/widgets/status_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppsScreen extends ConsumerStatefulWidget {
  const AppsScreen({super.key});

  @override
  ConsumerState createState() => _AppsScreenState();
}

class _AppsScreenState extends ConsumerState<AppsScreen> with CustomScreen {
  /// Briefly replaces the status bar title to acknowledge a pin or unpin,
  /// since the row marker alone is easy to miss in a long list.
  String? _pinFeedbackTitle;
  Timer? _pinFeedbackTimer;

  @override
  String get routeName => Routes.apps.name;

  @override
  List<AppInfo> get displayItems =>
      ref.read(installedAppsProvider).value ?? const [];

  @override
  Future<void> onSelectPressed() => _launchApp(selectedDisplayItem);

  @override
  void onSelectLongPress() {
    unawaited(_togglePinned(selectedDisplayItem));
  }

  /// Long pressing select pins the app to the main menu, so it can be launched
  /// without opening this screen, and long pressing again unpins it.
  Future<void> _togglePinned(int index) async {
    final installedApps = displayItems;
    if (index < 0 || index >= installedApps.length) {
      return;
    }
    final isNowPinned = await ref
        .read(pinnedAppsControllerProvider.notifier)
        .togglePinned(installedApps[index].packageName);
    if (!mounted) {
      return;
    }
    _showPinFeedback(
      isNowPinned
          ? context.localization.appPinnedMessage
          : context.localization.appUnpinnedMessage,
    );
  }

  void _showPinFeedback(String message) {
    _pinFeedbackTimer?.cancel();
    setState(() => _pinFeedbackTitle = message);
    _pinFeedbackTimer = Timer(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() => _pinFeedbackTitle = null);
      }
    });
  }

  @override
  void dispose() {
    _pinFeedbackTimer?.cancel();
    super.dispose();
  }

  Future<void> _launchApp(int index) async {
    final installedApps = displayItems;
    if (index < 0 || index >= installedApps.length) {
      return;
    }
    setState(() => selectedDisplayItem = index);
    await InstalledApps.startApp(installedApps[index].packageName);
  }

  @override
  Widget build(BuildContext context) {
    final installedApps = ref.watch(installedAppsProvider);
    final pinnedApps = ref.watch(pinnedAppsControllerProvider);

    return CupertinoPageScaffold(
      child: Column(
        children: [
          StatusBar(
            title: _pinFeedbackTitle ?? Routes.apps.title(context),
          ),
          Expanded(
            child: installedApps.when(
              loading: () =>
                  const Center(child: CupertinoActivityIndicator(radius: 12)),
              error: (error, stackTrace) => EmptyStateWidget(
                emptyDescription: context.localization.noAppsFound,
              ),
              data: (apps) {
                if (apps.isEmpty) {
                  return EmptyStateWidget(
                    emptyDescription: context.localization.noAppsFound,
                  );
                }
                return CupertinoScrollbar(
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: apps.length,
                    prototypeItem: const DisplayListTile(
                      text: '',
                      isSelected: false,
                    ),
                    itemBuilder: (context, index) {
                      final isPinned = pinnedApps.contains(
                        apps[index].packageName,
                      );
                      return DisplayListTile(
                        key: ValueKey(apps[index].packageName),
                        text: isPinned
                            ? "${apps[index].name} •"
                            : apps[index].name,
                        isSelected: selectedDisplayItem == index,
                        onTap: () async => _launchApp(index),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

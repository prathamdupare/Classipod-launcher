import 'package:classipod/core/extensions/build_context_extensions.dart';
import 'package:classipod/core/navigation/routes.dart';
import 'package:classipod/core/widgets/display_list_tile.dart';
import 'package:classipod/core/widgets/empty_state_widget.dart';
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
  @override
  String get routeName => Routes.apps.name;

  @override
  List<AppInfo> get displayItems =>
      ref.read(installedAppsProvider).valueOrNull ?? const [];

  @override
  Future<void> onSelectPressed() => _launchApp(selectedDisplayItem);

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

    return CupertinoPageScaffold(
      child: Column(
        children: [
          StatusBar(title: Routes.apps.title(context)),
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
                    itemBuilder: (context, index) => DisplayListTile(
                      key: ValueKey(apps[index].packageName),
                      text: apps[index].name,
                      isSelected: selectedDisplayItem == index,
                      onTap: () async => _launchApp(index),
                    ),
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

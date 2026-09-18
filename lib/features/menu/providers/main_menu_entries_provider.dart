import 'package:classipod/features/apps/controllers/pinned_apps_controller.dart';
import 'package:classipod/features/apps/providers/installed_apps_provider.dart';
import 'package:classipod/features/menu/models/main_menu_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/app_info.dart';

/// The rows shown on the main menu, with the user's pinned apps spliced in
/// below Music so they can be launched without opening the Apps screen.
///
/// A pinned package that is no longer installed simply drops out of the list.
final mainMenuEntriesProvider = Provider<List<MainMenuEntry>>((ref) {
  final pinnedPackageNames = ref.watch(pinnedAppsControllerProvider);
  final installedApps =
      ref.watch(installedAppsProvider).value ?? const <AppInfo>[];
  final appsByPackageName = {
    for (final installedApp in installedApps)
      installedApp.packageName: installedApp,
  };

  final pinnedEntries = <PinnedAppEntry>[];
  for (final packageName in pinnedPackageNames) {
    final pinnedApp = appsByPackageName[packageName];
    if (pinnedApp != null) {
      pinnedEntries.add(PinnedAppEntry(pinnedApp));
    }
  }

  return [
    const MainMenuActionEntry(MainMenuAction.music),
    ...pinnedEntries,
    const MainMenuActionEntry(MainMenuAction.apps),
    const MainMenuActionEntry(MainMenuAction.settings),
    const MainMenuActionEntry(MainMenuAction.shuffleSongs),
    const MainMenuActionEntry(MainMenuAction.nowPlaying),
  ];
});

import 'package:classipod/features/settings/repository/settings_preferences_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pinnedAppsControllerProvider =
    NotifierProvider<PinnedAppsControllerNotifier, List<String>>(
      PinnedAppsControllerNotifier.new,
    );

/// The package names the user has promoted onto the main menu, in the order
/// they were pinned.
class PinnedAppsControllerNotifier extends Notifier<List<String>> {
  PinnedAppsControllerNotifier() : super();

  @override
  List<String> build() {
    return ref.read(settingsPreferencesRepositoryProvider).getPinnedApps();
  }

  bool isPinned(String packageName) => state.contains(packageName);

  /// Pins [packageName] if it is not already pinned, and unpins it otherwise.
  ///
  /// Returns true when the app ended up pinned.
  Future<bool> togglePinned(String packageName) async {
    final updatedPinnedApps = [...state];
    final wasPinned = updatedPinnedApps.remove(packageName);
    if (!wasPinned) {
      updatedPinnedApps.add(packageName);
    }
    state = updatedPinnedApps;
    await ref
        .read(settingsPreferencesRepositoryProvider)
        .setPinnedApps(packageNames: updatedPinnedApps);
    return !wasPinned;
  }
}

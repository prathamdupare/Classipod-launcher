import 'package:classipod/core/extensions/build_context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:installed_apps/app_info.dart';

/// A row on the main menu.
///
/// The menu mixes fixed destinations with the apps the user has pinned, so the
/// rows cannot be a plain enum.
sealed class MainMenuEntry {
  const MainMenuEntry();

  String title(BuildContext context);
}

/// One of the built-in main menu destinations.
class MainMenuActionEntry extends MainMenuEntry {
  final MainMenuAction action;

  const MainMenuActionEntry(this.action);

  @override
  String title(BuildContext context) => action.title(context);

  @override
  bool operator ==(Object other) =>
      other is MainMenuActionEntry && other.action == action;

  @override
  int get hashCode => action.hashCode;
}

/// An app the user pinned to the main menu.
class PinnedAppEntry extends MainMenuEntry {
  final AppInfo appInfo;

  const PinnedAppEntry(this.appInfo);

  @override
  String title(BuildContext context) => appInfo.name;

  @override
  bool operator ==(Object other) =>
      other is PinnedAppEntry &&
      other.appInfo.packageName == appInfo.packageName;

  @override
  int get hashCode => appInfo.packageName.hashCode;
}

enum MainMenuAction {
  music,
  apps,
  settings,
  shuffleSongs,
  nowPlaying;

  String title(BuildContext context) {
    switch (this) {
      case music:
        return context.localization.musicMenuScreenTitle;
      case apps:
        return context.localization.appsScreenTitle;
      case settings:
        return context.localization.settingsScreenTitle;
      case shuffleSongs:
        return context.localization.shuffleSongsMenuTitle;
      case nowPlaying:
        return context.localization.nowPlayingScreenTitle;
    }
  }
}

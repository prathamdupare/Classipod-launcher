import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

/// The launchable apps installed on the device, sorted by display name.
///
/// Only Android exposes an app list, so every other platform resolves to an
/// empty list and the apps menu entry falls back to its empty state.
final installedAppsProvider = FutureProvider<List<AppInfo>>((ref) async {
  if (kIsWeb || !Platform.isAndroid) {
    return const [];
  }
  final installedApps = await InstalledApps.getInstalledApps(
    withIcon: false,
  );
  installedApps.sort(
    (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
  );
  return installedApps;
});

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
  // System apps have to be included or the launcher hides the phone, clock,
  // camera and messaging apps. Non launchable packages stay excluded so the
  // list is apps rather than every background service on the device.
  final installedApps = await InstalledApps.getInstalledApps(
    excludeSystemApps: false,
  );
  installedApps.sort(
    (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
  );
  return installedApps;
});

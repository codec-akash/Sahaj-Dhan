import 'dart:async';

import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';

import '../models/update_info_model.dart';
import 'update_data_source.dart';

class AndroidUpdateDataSource implements UpdateDataSource {
  @override
  Future<UpdateInfoModel> checkForUpdate() async {
    try {
      final appUpdateInfo = await InAppUpdate.checkForUpdate();
      final currentVersion = await _getCurrentVersion();

      return UpdateInfoModel(
        currentVersion: currentVersion,
        newVersion:
            appUpdateInfo.availableVersionCode?.toString() ?? currentVersion,
        changelog: appUpdateInfo.updateAvailability ==
                UpdateAvailability.updateAvailable
            ? 'A new version is available with improvements and bug fixes'
            : '',
        isUpdateAvailable: appUpdateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable,
        installStatus: InstallStatus.unknown,
      );
    } catch (e) {
      throw UpdateException('Failed to check for updates: $e', 500);
    }
  }

  @override
  Future<void> startUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
    } catch (e) {
      throw UpdateException('Failed to start update: $e', 500);
    }
  }

  @override
  Stream<InstallStatus> getUpdateProgress() {
    return InAppUpdate.installUpdateListener;
  }

  @override
  Future<void> completeUpdate() async {
    try {
      await InAppUpdate.completeFlexibleUpdate();
    } catch (e) {
      throw UpdateException('Failed to complete update: $e', 500);
    }
  }

  Future<String> _getCurrentVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }
}

import 'dart:async';

import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';

import '../../domain/entities/update_info.dart';
import '../models/update_info_model.dart';
import 'update_data_source.dart';

class AndroidUpdateDataSource implements UpdateDataSource {
  final StreamController<InstallStatus> _statusController;
  StreamSubscription? _installStatusSubscription;

  AndroidUpdateDataSource()
      : _statusController = StreamController<InstallStatus>.broadcast() {
    // Listen to install status updates
    _installStatusSubscription = InAppUpdate.installUpdateListener.listen(
      (status) => _statusController.add(status),
    );
  }

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
  Stream<InstallStatus> getUpdateProgress() => _statusController.stream;

  Future<String> _getCurrentVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  void dispose() {
    _installStatusSubscription?.cancel();
    _statusController.close();
  }
}

import 'dart:async';

import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';

import '../../domain/entities/update_info.dart';
import '../models/update_info_model.dart';
import 'update_data_source.dart';

class AndroidUpdateDataSource implements UpdateDataSource {
  final StreamController<double> _progressController;

  AndroidUpdateDataSource()
      : _progressController = StreamController<double>.broadcast();

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
        status: appUpdateInfo.updateAvailability ==
                UpdateAvailability.updateAvailable
            ? UpdateStatus.available
            : UpdateStatus.none,
      );
    } catch (e) {
      throw UpdateException('Failed to check for updates: $e', 500);
    }
  }

  @override
  Future<void> startUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      _progressController.add(0.0);
      // Simulate progress for flexible update since the actual API doesn't provide progress
      _simulateProgress();
    } catch (e) {
      throw UpdateException('Failed to start update: $e', 500);
    }
  }

  @override
  Stream<double> getUpdateProgress() => _progressController.stream;

  void _simulateProgress() {
    double progress = 0.0;
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      progress += 0.1;
      if (progress >= 1.0) {
        timer.cancel();
        _progressController.add(1.0);
        _completeUpdate();
      } else {
        _progressController.add(progress);
      }
    });
  }

  Future<void> _completeUpdate() async {
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

  void dispose() {
    _progressController.close();
  }
}

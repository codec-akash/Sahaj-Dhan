import 'package:in_app_update/in_app_update.dart';
import 'package:sahaj_dhan/features/app_update/data/models/update_info_model.dart';

abstract class UpdateDataSource {
  /// Checks if an update is available
  Future<UpdateInfoModel> checkForUpdate();

  /// Starts the update process
  Future<void> startUpdate();

  /// Gets the update installation status
  Stream<InstallStatus> getUpdateProgress();

  /// Completes the update installation
  Future<void> completeUpdate();
}

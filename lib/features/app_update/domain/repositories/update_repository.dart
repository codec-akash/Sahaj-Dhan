import 'package:in_app_update/in_app_update.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';

import '../entities/update_info.dart';

abstract class UpdateRepository {
  /// Checks if an update is available
  FutureResult<UpdateInfo> checkForUpdate();

  /// Starts the update process
  FutureResult<void> startUpdate();

  /// Gets the update installation status
  StreamResult<InstallStatus> getUpdateProgress();

  /// Completes the update installation
  FutureResult<void> completeUpdate();
}

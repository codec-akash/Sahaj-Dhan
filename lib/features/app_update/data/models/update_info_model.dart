import 'package:in_app_update/in_app_update.dart';

import '../../domain/entities/update_info.dart';

class UpdateInfoModel extends UpdateInfo {
  const UpdateInfoModel({
    required super.currentVersion,
    required super.newVersion,
    required super.changelog,
    required super.isUpdateAvailable,
    super.installStatus = InstallStatus.unknown,
  });

  factory UpdateInfoModel.fromJson(Map<String, dynamic> json) {
    return UpdateInfoModel(
      currentVersion: json['currentVersion'] as String,
      newVersion: json['newVersion'] as String,
      changelog: json['changelog'] as String,
      isUpdateAvailable: json['isUpdateAvailable'] as bool,
      installStatus: InstallStatus.values.firstWhere(
        (e) => e.toString() == json['installStatus'],
        orElse: () => InstallStatus.unknown,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentVersion': currentVersion,
      'newVersion': newVersion,
      'changelog': changelog,
      'isUpdateAvailable': isUpdateAvailable,
    };
  }
}

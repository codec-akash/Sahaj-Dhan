import '../../domain/entities/update_info.dart';

class UpdateInfoModel extends UpdateInfo {
  const UpdateInfoModel({
    required super.currentVersion,
    required super.newVersion,
    required super.changelog,
    required super.isUpdateAvailable,
    super.downloadProgress = 0.0,
    super.status = UpdateStatus.none,
  });

  factory UpdateInfoModel.fromJson(Map<String, dynamic> json) {
    return UpdateInfoModel(
      currentVersion: json['currentVersion'] as String,
      newVersion: json['newVersion'] as String,
      changelog: json['changelog'] as String,
      isUpdateAvailable: json['isUpdateAvailable'] as bool,
      downloadProgress: (json['downloadProgress'] as num?)?.toDouble() ?? 0.0,
      status: UpdateStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => UpdateStatus.none,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentVersion': currentVersion,
      'newVersion': newVersion,
      'changelog': changelog,
      'isUpdateAvailable': isUpdateAvailable,
      'downloadProgress': downloadProgress,
      'status': status.toString(),
    };
  }
}

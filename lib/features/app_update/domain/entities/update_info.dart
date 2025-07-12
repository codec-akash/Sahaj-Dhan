import 'package:equatable/equatable.dart';

enum UpdateStatus { none, available, downloading, completed, error }

class UpdateInfo extends Equatable {
  final String currentVersion;
  final String newVersion;
  final String changelog;
  final bool isUpdateAvailable;
  final double downloadProgress;
  final UpdateStatus status;

  const UpdateInfo({
    required this.currentVersion,
    required this.newVersion,
    required this.changelog,
    required this.isUpdateAvailable,
    this.downloadProgress = 0.0,
    this.status = UpdateStatus.none,
  });

  @override
  List<Object?> get props => [
        currentVersion,
        newVersion,
        changelog,
        isUpdateAvailable,
        downloadProgress,
        status,
      ];

  UpdateInfo copyWith({
    String? currentVersion,
    String? newVersion,
    String? changelog,
    bool? isUpdateAvailable,
    double? downloadProgress,
    UpdateStatus? status,
  }) {
    return UpdateInfo(
      currentVersion: currentVersion ?? this.currentVersion,
      newVersion: newVersion ?? this.newVersion,
      changelog: changelog ?? this.changelog,
      isUpdateAvailable: isUpdateAvailable ?? this.isUpdateAvailable,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      status: status ?? this.status,
    );
  }
}

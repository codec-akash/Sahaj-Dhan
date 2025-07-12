import 'package:equatable/equatable.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdateInfo extends Equatable {
  final String currentVersion;
  final String newVersion;
  final String changelog;
  final bool isUpdateAvailable;
  final InstallStatus installStatus;

  const UpdateInfo({
    required this.currentVersion,
    required this.newVersion,
    required this.changelog,
    required this.isUpdateAvailable,
    this.installStatus = InstallStatus.unknown,
  });

  @override
  List<Object?> get props => [
        currentVersion,
        newVersion,
        changelog,
        isUpdateAvailable,
        installStatus,
      ];

  UpdateInfo copyWith({
    String? currentVersion,
    String? newVersion,
    String? changelog,
    bool? isUpdateAvailable,
    InstallStatus? installStatus,
  }) {
    return UpdateInfo(
      currentVersion: currentVersion ?? this.currentVersion,
      newVersion: newVersion ?? this.newVersion,
      changelog: changelog ?? this.changelog,
      isUpdateAvailable: isUpdateAvailable ?? this.isUpdateAvailable,
      installStatus: installStatus ?? this.installStatus,
    );
  }
}

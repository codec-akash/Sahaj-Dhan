import 'package:equatable/equatable.dart';

import '../../domain/entities/update_info.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object?> get props => [];
}

class UpdateInitial extends UpdateState {}

class UpdateAvailable extends UpdateState {
  final UpdateInfo updateInfo;

  const UpdateAvailable(this.updateInfo);

  @override
  List<Object?> get props => [updateInfo];
}

class UpdateDownloading extends UpdateState {
  final UpdateInfo updateInfo;

  const UpdateDownloading({
    required this.updateInfo,
  });

  @override
  List<Object?> get props => [updateInfo];
}

class UpdateError extends UpdateState {
  final String message;

  const UpdateError(this.message);

  @override
  List<Object?> get props => [message];
}

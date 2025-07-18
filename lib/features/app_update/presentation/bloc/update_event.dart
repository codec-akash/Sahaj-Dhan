import 'package:equatable/equatable.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object?> get props => [];
}

class CheckForUpdate extends UpdateEvent {}

class StartUpdate extends UpdateEvent {}

class DismissUpdate extends UpdateEvent {}

class CompleteUpdate extends UpdateEvent {}

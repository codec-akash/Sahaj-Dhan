import 'package:equatable/equatable.dart';
import 'package:sahaj_dhan/blocs/user_bloc/user_event.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends UserState {
  @override
  String toString() => 'Uninitialized';
}

class UserStateLoading extends UserState {
  final UserEvent currentEvent;

  const UserStateLoading({required this.currentEvent});
}

class UserStateFailed extends UserState {
  final UserEvent currentEvent;
  final String errorMsg;

  const UserStateFailed({
    required this.currentEvent,
    required this.errorMsg,
  });
}

class UserTokenSent extends UserState {}

class CheckAddedForToken extends UserState {}

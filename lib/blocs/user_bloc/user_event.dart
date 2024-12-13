import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CheckCanSendToken extends UserEvent {}

class SendUserToken extends UserEvent {
  final String token;
  final String deviceID;

  const SendUserToken({required this.token, required this.deviceID});
}

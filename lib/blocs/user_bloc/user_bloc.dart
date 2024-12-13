import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/blocs/user_bloc/user_event.dart';
import 'package:sahaj_dhan/blocs/user_bloc/user_state.dart';
import 'package:sahaj_dhan/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository = UserRepository();
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      // For Android
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Returns a unique device ID for Android
    } else {
      // For iOS
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ??
          ""; // Returns a unique device ID for iOS
    }
  }

  UserBloc() : super(Uninitialized()) {
    _firebaseMessaging.onTokenRefresh.listen((event) async {
      String deviceId = await getDeviceId();
      add(SendUserToken(token: event, deviceID: deviceId));
    });
    on<SendUserToken>(_sendUserToken);
    on<CheckCanSendToken>(_canSendToken);
  }

  Future<void> _sendUserToken(
      SendUserToken event, Emitter<UserState> emit) async {
    try {
      emit(UserStateLoading(currentEvent: event));
      userRepository.sendUserToken({
        "platform": Platform.isAndroid ? "ANDROID" : "IOS",
        "token": event.token,
        "deviceId": event.deviceID
      });
      emit(UserTokenSent());
    } catch (e) {
      emit(UserStateFailed(currentEvent: event, errorMsg: e.toString()));
    }
  }

  Future<void> _canSendToken(
      CheckCanSendToken event, Emitter<UserState> emit) async {
    try {
      emit(UserStateLoading(currentEvent: event));
      String? token = await _firebaseMessaging.getToken();
      String deviceId = await getDeviceId();
      if (token != null) {
        add(SendUserToken(token: token, deviceID: deviceId));
      }
      emit(CheckAddedForToken());
    } catch (e) {
      emit(UserStateFailed(currentEvent: event, errorMsg: e.toString()));
    }
  }
}

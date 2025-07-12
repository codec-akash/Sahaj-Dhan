import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/check_update_usecase.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/start_update_usecase.dart';

import 'update_event.dart';
import 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final CheckUpdateUseCase checkUpdateUseCase;
  final StartUpdateUseCase startUpdateUseCase;
  StreamSubscription? _progressSubscription;

  UpdateBloc({
    required this.checkUpdateUseCase,
    required this.startUpdateUseCase,
  }) : super(UpdateInitial()) {
    on<CheckForUpdate>(_onCheckForUpdate);
    on<StartUpdate>(_onStartUpdate);
    on<DismissUpdate>(_onDismissUpdate);
  }

  Future<void> _onCheckForUpdate(
    CheckForUpdate event,
    Emitter<UpdateState> emit,
  ) async {
    final result = await checkUpdateUseCase();
    result.fold(
      (failure) => emit(UpdateError(failure.message)),
      (updateInfo) {
        if (updateInfo.isUpdateAvailable) {
          emit(UpdateAvailable(updateInfo));
        }
      },
    );
  }

  Future<void> _onStartUpdate(
    StartUpdate event,
    Emitter<UpdateState> emit,
  ) async {
    if (state is UpdateAvailable) {
      final updateInfo = (state as UpdateAvailable).updateInfo;
      final result = await startUpdateUseCase();
      result.fold(
        (failure) => emit(UpdateError(failure.message)),
        (_) => emit(UpdateDownloading(progress: 0.0, updateInfo: updateInfo)),
      );
    }
  }

  void _onDismissUpdate(
    DismissUpdate event,
    Emitter<UpdateState> emit,
  ) {
    emit(UpdateInitial());
  }

  @override
  Future<void> close() {
    _progressSubscription?.cancel();
    return super.close();
  }
}

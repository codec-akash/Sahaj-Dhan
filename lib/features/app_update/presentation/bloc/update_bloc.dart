import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/check_update_usecase.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/complete_update_usecase.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/get_update_status_usecase.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/start_update_usecase.dart';

import 'update_event.dart';
import 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final CheckUpdateUseCase checkUpdateUseCase;
  final StartUpdateUseCase startUpdateUseCase;
  final GetUpdateStatusUseCase getUpdateStatusUseCase;
  final CompleteUpdateUseCase completeUpdateUseCase;

  UpdateBloc({
    required this.checkUpdateUseCase,
    required this.startUpdateUseCase,
    required this.getUpdateStatusUseCase,
    required this.completeUpdateUseCase,
  }) : super(UpdateInitial()) {
    on<CheckForUpdate>(_onCheckForUpdate);
    on<StartUpdate>(_onStartUpdate);
    on<DismissUpdate>(_onDismissUpdate);
    on<CompleteUpdate>(_onCompleteUpdate);
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
      final result = await startUpdateUseCase();
      add(CompleteUpdate());
      result.fold(
        (failure) => emit(UpdateError(failure.message)),
        (_) => emit(UpdateDownloading(
          updateInfo: (state as UpdateAvailable).updateInfo,
        )),
      );
    }
  }

  Future<void> _onCompleteUpdate(
    CompleteUpdate event,
    Emitter<UpdateState> emit,
  ) async {
    final result = await completeUpdateUseCase();
    result.fold(
      (failure) => emit(UpdateError(failure.message)),
      (_) => emit(UpdateDownloading(
        updateInfo: (state as UpdateDownloading).updateInfo,
      )),
    );
  }

  void _onDismissUpdate(
    DismissUpdate event,
    Emitter<UpdateState> emit,
  ) {
    emit(UpdateInitial());
  }
}

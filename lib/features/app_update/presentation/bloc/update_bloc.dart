import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/check_update_usecase.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/get_update_status_usecase.dart';
import 'package:sahaj_dhan/features/app_update/domain/usecases/start_update_usecase.dart';

import 'update_event.dart';
import 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final CheckUpdateUseCase checkUpdateUseCase;
  final StartUpdateUseCase startUpdateUseCase;
  final GetUpdateStatusUseCase getUpdateStatusUseCase;
  StreamSubscription? _statusSubscription;

  UpdateBloc({
    required this.checkUpdateUseCase,
    required this.startUpdateUseCase,
    required this.getUpdateStatusUseCase,
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
      final result = await startUpdateUseCase();
      result.fold(
        (failure) => emit(UpdateError(failure.message)),
        (_) {
          // Start listening to installation status
          _statusSubscription?.cancel();
          _statusSubscription = getUpdateStatusUseCase().listen(
            (result) => result.fold(
              (failure) => emit(UpdateError(failure.message)),
              (status) {
                if (state is UpdateAvailable || state is UpdateDownloading) {
                  final currentInfo = (state as dynamic).updateInfo;
                  emit(UpdateDownloading(
                    updateInfo: currentInfo.copyWith(installStatus: status),
                  ));
                }
              },
            ),
          );
        },
      );
    }
  }

  void _onDismissUpdate(
    DismissUpdate event,
    Emitter<UpdateState> emit,
  ) {
    _statusSubscription?.cancel();
    emit(UpdateInitial());
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    return super.close();
  }
}

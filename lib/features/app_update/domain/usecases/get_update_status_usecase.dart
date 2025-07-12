import 'package:dartz/dartz.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import '../repositories/update_repository.dart';

class GetUpdateStatusUseCase
    extends BaseStreamUsecaseWithoutParams<InstallStatus> {
  final UpdateRepository repository;

  const GetUpdateStatusUseCase(this.repository);

  @override
  StreamResult<InstallStatus> call() {
    try {
      return repository.getUpdateProgress().map((status) => status.fold(
            (failure) => Left(failure),
            (status) => Right(status),
          ));
    } catch (e) {
      return Stream.value(Left(UpdateFailure(message: e.toString())));
    }
  }
}

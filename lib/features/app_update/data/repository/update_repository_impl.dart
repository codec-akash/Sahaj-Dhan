import 'package:dartz/dartz.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/app_update/data/datasource/update_data_source.dart';
import 'package:sahaj_dhan/features/app_update/domain/entities/update_info.dart';
import 'package:sahaj_dhan/features/app_update/domain/repositories/update_repository.dart';

class UpdateRepositoryImpl implements UpdateRepository {
  final UpdateDataSource dataSource;

  UpdateRepositoryImpl(this.dataSource);

  @override
  FutureResult<UpdateInfo> checkForUpdate() async {
    try {
      final result = await dataSource.checkForUpdate();
      return Right(result);
    } catch (e) {
      return Left(UpdateFailure(message: e.toString()));
    }
  }

  @override
  FutureResult<void> startUpdate() async {
    try {
      await dataSource.startUpdate();
      return const Right(null);
    } catch (e) {
      return Left(UpdateFailure(message: e.toString()));
    }
  }

  @override
  StreamResult<InstallStatus> getUpdateProgress() {
    try {
      return dataSource.getUpdateProgress().map((status) => Right(status));
    } catch (e) {
      return Stream.value(Left(UpdateFailure(message: e.toString())));
    }
  }
}

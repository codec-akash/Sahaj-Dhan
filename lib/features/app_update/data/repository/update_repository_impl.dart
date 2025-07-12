import 'package:dartz/dartz.dart';
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
      return Right(null);
    } catch (e) {
      return Left(UpdateFailure(message: e.toString()));
    }
  }

  @override
  Stream<double> getUpdateProgress() => dataSource.getUpdateProgress();
}

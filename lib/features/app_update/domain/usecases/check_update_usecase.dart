import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/app_update/domain/entities/update_info.dart';
import 'package:sahaj_dhan/features/app_update/domain/repositories/update_repository.dart';

class CheckUpdateUseCase implements BaseUsecaseWithoutParams<UpdateInfo> {
  final UpdateRepository repository;

  CheckUpdateUseCase(this.repository);

  @override
  FutureResult<UpdateInfo> call() async {
    return await repository.checkForUpdate();
  }
}

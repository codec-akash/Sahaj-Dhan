import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/app_update/domain/repositories/update_repository.dart';

class StartUpdateUseCase implements BaseUsecaseWithoutParams<void> {
  final UpdateRepository repository;

  StartUpdateUseCase(this.repository);

  @override
  FutureResult<void> call() async {
    return await repository.startUpdate();
  }
}

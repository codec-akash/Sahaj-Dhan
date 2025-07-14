import 'package:sahaj_dhan/core/usecase/base_usecase.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/app_update/domain/repositories/update_repository.dart';

class CompleteUpdateUseCase extends BaseUsecaseWithoutParams<void> {
  final UpdateRepository repository;

  const CompleteUpdateUseCase(this.repository);

  @override
  FutureResult<void> call() async {
    return await repository.completeUpdate();
  }
}

import 'package:sahaj_dhan/core/utils/typedef.dart';

abstract class BaseUsecaseWithParams<Type, Params> {
  const BaseUsecaseWithParams();
  FutureResult<Type> call(Params params);
}

abstract class BaseUsecaseWithoutParams<Type> {
  const BaseUsecaseWithoutParams();
  FutureResult<Type> call();
}

import 'package:dartz/dartz.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;

import 'package:dartz/dartz.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/errors/failure.dart';
import 'package:sahaj_dhan/core/utils/typedef.dart';
import 'package:sahaj_dhan/features/top_investors/data/datasources/top_investor_data_source.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';
import 'package:sahaj_dhan/features/top_investors/domain/repositories/top_investor_repo.dart';

class TopInvestorRepoImpl implements TopInvestorRepo {
  final TopInvestorDataSource _topInvestorDataSource;

  const TopInvestorRepoImpl({
    required TopInvestorDataSource topInvestorDataSource,
  }) : _topInvestorDataSource = topInvestorDataSource;

  @override
  FutureResult<List<TopInvestor>> getTopInvestors() async {
    try {
      List<TopInvestor> topInvestors =
          await _topInvestorDataSource.getTopInvestors();

      return Right(topInvestors);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExpection(e));
    }
  }
}

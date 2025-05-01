import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';
import 'package:sahaj_dhan/features/top_investors/domain/repositories/top_investor_repo.dart';
import 'package:sahaj_dhan/features/top_investors/domain/usercases/get_top_investor_usecase.dart';

class MockTopInvestorRepo extends Mock implements TopInvestorRepo {}

void main() {
  late GetTopInvestorUsecase getTopInvestorUsecase;
  late TopInvestorRepo topInvestorRepo;

  setUp(() {
    topInvestorRepo = MockTopInvestorRepo();
    getTopInvestorUsecase = GetTopInvestorUsecase(topInvestorRepo);
  });

  const tResponse = <TopInvestor>[];

  test("should call the [Repo.getTopInvestor] and return [List<TopInvestor>]",
      () async {
    when(() => topInvestorRepo.getTopInvestors())
        .thenAnswer((_) async => const Right(tResponse));

    final result = await getTopInvestorUsecase.call();

    expect(result, equals(const Right<dynamic, List<TopInvestor>>(tResponse)));

    verify(() => topInvestorRepo.getTopInvestors()).called(1);

    verifyNoMoreInteractions(topInvestorRepo);
  });
}

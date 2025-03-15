import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';

class MockStocksRepo extends Mock implements StocksRepository {}

void main() {
  late GetStocksList getStocksList;
  late StocksRepository stockRepository;

  setUp(() {
    stockRepository = MockStocksRepo();
    getStocksList = GetStocksList(stockRepo: stockRepository);
  });

  const tResponse = <Stock>[];

  test("should call the [Repo.getStocksList] and return [List<Stock>]",
      () async {
    when(() => stockRepository.getStocksList(page: 0))
        .thenAnswer((_) async => const Right(tResponse));

    final result = await getStocksList(0);

    expect(result, equals(const Right<dynamic, List<Stock>>(tResponse)));

    verify(() => stockRepository.getStocksList(page: 0)).called(1);
    verifyNoMoreInteractions(stockRepository);
  });
}

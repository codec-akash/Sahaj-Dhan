import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/repositories/stock_repository.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/usecases/get_stockslist_usecase.dart';

class MockStocksRepo extends Mock implements StockRepository {}

void main() {
  late GetStocksList getStocksList;
  late StockRepository stockRepository;

  setUp(() {
    stockRepository = MockStocksRepo();
    getStocksList = GetStocksList(stockRepo: stockRepository);
  });

  const tResponse = <Stock>[];

  test("should call the [Repo.getStocksList] and return [List<Stock>]",
      () async {
    when(() => stockRepository.getStocksList())
        .thenAnswer((_) async => const Right(tResponse));

    final result = await getStocksList();

    expect(result, equals(const Right<dynamic, List<Stock>>(tResponse)));

    verify(() => stockRepository.getStocksList()).called(1);
    verifyNoMoreInteractions(stockRepository);
  });
}

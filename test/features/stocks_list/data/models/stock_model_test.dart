import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sahaj_dhan/features/stocks_list/data/models/stock_model.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tJson = fixture('stock.json');
  final tMap = jsonDecode(tJson) as Map<String, dynamic>;
  const tstockModel = StockModel.empty();

  group("User Model test cases", () {
    test("should be a subclass of [Stock] entity", () {
      expect(tstockModel, isA<Stock>());
    });
    test("should return [StockModel] with right data fromMap", () {
      final result = StockModel.fromJson(tMap);

      expect(result, equals(tstockModel));
    });

    test("should return Tojson with right data [StockModel]", () {
      final result = tstockModel.toJson();

      expect(result, equals(tMap));
    });

    test("copywith - test should return [StockModel] with copywith ", () {
      final tResult = tstockModel.copyWith(securityName: "Akash");

      expect(tResult.securityName, equals("Akash"));
    });
  });
}

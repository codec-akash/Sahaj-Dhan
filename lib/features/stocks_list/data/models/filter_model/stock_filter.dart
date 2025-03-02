import 'package:json_annotation/json_annotation.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/filter.dart';

part 'stock_filter.g.dart';

@JsonSerializable()
class StockFilterModel extends StocksFilter {
  const StockFilterModel({
    required super.securityName,
    required super.symbol,
  });

  factory StockFilterModel.fromJson(Map<String, dynamic> json) =>
      _$StockFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockFilterModelToJson(this);
}

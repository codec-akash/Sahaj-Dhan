import 'package:json_annotation/json_annotation.dart';
import 'package:sahaj_dhan/features/stocks_list/data/models/filter_model/stock_filter.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/filter.dart';

part 'filter_model.g.dart';

@JsonSerializable()
class FilterModel extends Filter {
  const FilterModel({
    required super.clientName,
    required super.stocksFilter,
    required super.tradeType,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterModelToJson(this);
}

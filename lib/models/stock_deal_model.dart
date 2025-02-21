import 'package:sahaj_dhan/utils/types.dart';

class StockDeals {
  List<Deal>? result;
  num? totalItems;
  bool? hasNextPage;

  StockDeals({this.result, this.totalItems, this.hasNextPage});

  StockDeals.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      result = <Deal>[];
      json['data'].forEach((v) {
        result!.add(Deal.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    hasNextPage = json['hasNextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = totalItems;
    data['hasNextPage'] = hasNextPage;
    return data;
  }
}

class Deal {
  late String id;
  String? clientName;
  num? quantity;
  late String securityName;
  String? symbol;
  late num tradePrice;
  late String tradeType;
  String? executedAt;

  Deal({
    required this.id,
    this.clientName,
    this.quantity,
    this.symbol,
    required this.securityName,
    required this.tradePrice,
    required this.tradeType,
    this.executedAt,
  });

  DealTradeType get dealTradeType => DealTradeType.fromText(tradeType);

  Deal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    clientName = json['clientName'];
    quantity = json['quantityTraded'];
    securityName = json['securityName'];
    symbol = json['symbol'];
    tradePrice = num.parse(json['tradePrice']);
    tradeType = json['tradeType'];
    executedAt = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientName'] = clientName;
    data['quantityTraded'] = quantity;
    data['securityName'] = securityName;
    data['symbol'] = symbol;
    data['tradePrice'] = tradePrice;
    data['tradeType'] = tradeType;
    data['date'] = executedAt;
    return data;
  }
}

import 'package:sahaj_dhan/utils/types.dart';

class StockDeals {
  List<Deal>? result;
  num? totalCount;
  bool? isEndOfList;

  StockDeals({this.result, this.totalCount, this.isEndOfList});

  StockDeals.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Deal>[];
      json['result'].forEach((v) {
        result!.add(Deal.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    isEndOfList = json['isEndOfList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['isEndOfList'] = isEndOfList;
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
    id = json['id'];
    clientName = json['clientName'];
    quantity = json['quantity'];
    securityName = json['securityName'];
    symbol = json['symbol'];
    tradePrice = json['tradePrice'];
    tradeType = json['tradeType'];
    executedAt = json['executedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientName'] = clientName;
    data['quantity'] = quantity;
    data['securityName'] = securityName;
    data['symbol'] = symbol;
    data['tradePrice'] = tradePrice;
    data['tradeType'] = tradeType;
    data['executedAt'] = executedAt;
    return data;
  }
}

import 'package:flutter/material.dart';

enum DealTradeType {
  buy("BUY", Colors.green),
  sell("SELL", Colors.red),
  none("--", Colors.black);

  final String title;
  final Color textColor;

  const DealTradeType(this.title, this.textColor);

  static DealTradeType fromText(String text) {
    if (text == "BUY") {
      return DealTradeType.buy;
    } else if (text == "SELL") {
      return DealTradeType.sell;
    } else {
      return DealTradeType.none;
    }
  }
}

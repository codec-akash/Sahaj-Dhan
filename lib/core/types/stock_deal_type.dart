import 'package:flutter/material.dart';
import 'package:sahaj_dhan/core/utils/colors.dart';

enum StockDealType {
  buy("BUY", AppColor.buyTextColor, AppColor.buyColor),
  sell("SELL", AppColor.sellTextColor, AppColor.sellColor),
  none("--", AppColor.textColor, AppColor.textColor);

  final String title;
  final Color textColor;
  final Color color;

  const StockDealType(this.title, this.textColor, this.color);

  static StockDealType fromText(String text) {
    if (text == "BUY") {
      return StockDealType.buy;
    } else if (text == "SELL") {
      return StockDealType.sell;
    } else {
      return StockDealType.none;
    }
  }
}

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:sahaj_dhan/core/utils/colors.dart';

class LongTermStock extends Equatable {
  final int id;
  final String clientName;
  final String symbol;
  final String securityName;
  final String initialBuyDate;
  final int quantity;
  final String averageBuyPrice;
  final String? latestPrice;
  final String status;
  final bool isLongTerm;
  final double gainLossPercentage;
  final int holdingDuration;
  final String? closedDate;
  final String? closedPrice;
  final String createdAt;
  final String updatedAt;

  Color get capitalGainColor =>
      gainLossPercentage < 0 ? AppColor.sellTextColor : AppColor.buyTextColor;

  const LongTermStock({
    required this.id,
    required this.clientName,
    required this.symbol,
    required this.securityName,
    required this.initialBuyDate,
    required this.quantity,
    required this.averageBuyPrice,
    required this.latestPrice,
    required this.status,
    required this.isLongTerm,
    required this.gainLossPercentage,
    required this.holdingDuration,
    required this.closedDate,
    required this.closedPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        clientName,
        symbol,
        securityName,
        initialBuyDate,
        quantity,
        averageBuyPrice,
        latestPrice,
        status,
        isLongTerm,
        gainLossPercentage,
        holdingDuration,
        closedDate,
        closedPrice
      ];
}

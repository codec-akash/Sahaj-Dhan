import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/screen/long_term_stock_card.dart';

class LongTermStocksDateList extends StatelessWidget {
  final String date;
  final List<LongTermStock> dateStocks;
  const LongTermStocksDateList({
    super.key,
    required this.date,
    required this.dateStocks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.black12,
              Colors.transparent,
            ],
          )),
          child: Text(
            date,
            style: CustomTextTheme.text24,
          ),
        ),
        Column(
          children: dateStocks
              .map((stock) => LongTermStockCard(longTermStocks: stock))
              .toList(),
        )
      ],
    );
  }
}

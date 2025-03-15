import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/ui/stock_card.dart';

class StockDateList extends StatefulWidget {
  final String date;
  final List<Stock> dateStocks;
  const StockDateList({
    super.key,
    required this.dateStocks,
    required this.date,
  });

  @override
  State<StockDateList> createState() => _StockDateListState();
}

class _StockDateListState extends State<StockDateList> {
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
            widget.date,
            style: CustomTextTheme.text24,
          ),
        ),
        Column(
          children: widget.dateStocks
              .map((stock) => StockCard(stock: stock))
              .toList(),
        )
      ],
    );
  }
}

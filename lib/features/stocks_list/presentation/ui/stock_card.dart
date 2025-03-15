import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/extensions/widget_extension.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/core/utils/constant.dart';
import 'package:sahaj_dhan/core/utils/date_util.dart';
import 'package:sahaj_dhan/core/utils/strings.dart';
import 'package:sahaj_dhan/features/stocks_list/domain/entities/stock.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  const StockCard({
    super.key,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: stock.stockDealType.color.withOpacity(0.45),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                Strings.stockName,
                style: CustomTextTheme.text14,
              ).updateOpacity(Constant.widgetOpcatiy),
              Text(
                stock.symbol,
                style: CustomTextTheme.text14,
              ),
              const Spacer(),
              Text(
                DateTimeUtils.formatDateToReadable(stock.date),
                style: CustomTextTheme.text10,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.trader,
                style: CustomTextTheme.text14,
              ).updateOpacity(Constant.widgetOpcatiy),
              Expanded(
                child: Text(
                  stock.clientName,
                  style: CustomTextTheme.text14,
                ),
              ),
              SizedBox(width: 25.w),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            "${stock.tradeType} - ${stock.quantityTraded} qtn. - ${stock.tradePrice} ${Strings.inr}",
            style: CustomTextTheme.text12,
          )
        ],
      ),
    );
  }
}

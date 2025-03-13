import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/extensions/widget_extension.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/core/utils/constant.dart';
import 'package:sahaj_dhan/core/utils/date_util.dart';
import 'package:sahaj_dhan/core/utils/strings.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';

class LongTermStockCard extends StatelessWidget {
  final LongTermStocks longTermStocks;
  const LongTermStockCard({
    super.key,
    required this.longTermStocks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: longTermStocks.gainLossPercentage < 0
          ? Colors.red.withOpacity(0.4)
          : Colors.green.withOpacity(0.4),
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
                longTermStocks.symbol,
                style: CustomTextTheme.text14,
              ),
              const Spacer(),
              Text(
                DateTimeUtils.formatDateToReadable(
                    longTermStocks.closedDate ?? longTermStocks.createdAt),
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
                  longTermStocks.clientName,
                  style: CustomTextTheme.text14,
                ),
              ),
              SizedBox(width: 25.w),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            "",
            style: CustomTextTheme.text12,
          )
        ],
      ),
    );
  }
}

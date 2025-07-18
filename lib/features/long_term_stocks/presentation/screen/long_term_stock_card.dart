import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/extensions/widget_extension.dart';
import 'package:sahaj_dhan/core/navigation/navigation_service.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/core/utils/constant.dart';
import 'package:sahaj_dhan/core/utils/number_comma.dart';
import 'package:sahaj_dhan/core/utils/strings.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';

class LongTermStockCard extends StatelessWidget {
  final LongTermStock longTermStocks;
  final bool showClientName;
  const LongTermStockCard({
    super.key,
    required this.longTermStocks,
    this.showClientName = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showClientName) {
          di<NavigationService>()
              .navigateTo(RouteConfig.stocksHoldingInvestors, arguments: {
            'stockName': longTermStocks.securityName,
            'symbol': longTermStocks.symbol,
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.7, 1.0],
            colors: [
              Colors.transparent,
              longTermStocks.capitalGainColor.withValues(alpha: 0.4),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(
                    TextSpan(
                      text: longTermStocks.securityName.trim(),
                      style: CustomTextTheme.text14,
                      children: [
                        TextSpan(
                          text: "\n(${longTermStocks.symbol.trim()})",
                          style: CustomTextTheme.text12,
                        ),
                      ],
                    ),
                  ).updateOpacity(Constant.widgetOpcatiy),
                  SizedBox(height: 5.h),
                  Text.rich(
                    TextSpan(
                        text:
                            "${NumberUtils.addIndianCommas(longTermStocks.quantity)} qtn @ ",
                        style: CustomTextTheme.text12,
                        children: [
                          TextSpan(
                            text:
                                "${NumberUtils.addIndianCommas(double.tryParse(longTermStocks.averageBuyPrice) ?? 0)} ${Strings.inr}",
                            style: CustomTextTheme.text12
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                  SizedBox(height: 5.h),
                  Text.rich(
                    TextSpan(
                        text: "Total Investment: ",
                        style: CustomTextTheme.text12,
                        children: [
                          TextSpan(
                            text:
                                '${NumberUtils.addIndianCommas((double.tryParse(longTermStocks.averageBuyPrice) ?? 0) * (longTermStocks.quantity.toDouble()))} ${Strings.inr}',
                            style: CustomTextTheme.text12
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                  SizedBox(height: 5.h),
                  if (showClientName) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            longTermStocks.clientName.trim(),
                            style: CustomTextTheme.text14,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${longTermStocks.gainLossPercentage}%",
                  style: CustomTextTheme.text16Bold
                      .copyWith(color: longTermStocks.capitalGainColor),
                ),
                Text(
                  "in ${longTermStocks.holdingDuration} days",
                  style: CustomTextTheme.text12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

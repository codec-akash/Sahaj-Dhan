import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/navigation/navigation_service.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/core/utils/colors.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';

class TopInvestorCard extends StatelessWidget {
  final TopInvestor topInvestor;
  const TopInvestorCard({
    super.key,
    required this.topInvestor,
  });

  Widget textInfoWidget(String title, String value) {
    return Text.rich(
      TextSpan(
        text: title,
        children: [
          TextSpan(
            text: value,
            style: CustomTextTheme.text12Bold
                .copyWith(color: AppColor.buyTextColor),
          )
        ],
        style: CustomTextTheme.text12
            .copyWith(color: AppColor.textColor.withOpacity(0.7)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        di<NavigationService>()
            .navigateTo(RouteConfig.investorHolding, arguments: {
          'investor': topInvestor,
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topInvestor.clientName,
              style: CustomTextTheme.text14,
            ),
            SizedBox(height: 8.h),
            textInfoWidget("Total Profitable Trades -",
                " ${topInvestor.profitableTrades}#"),
            SizedBox(height: 4.h),
            textInfoWidget(
                "Avg. Profit% -", " ${topInvestor.averageGainPercentage}%"),
            SizedBox(height: 4.h),
            textInfoWidget(
                "Highest Profit% -", " ${topInvestor.highestGainPercentage}%"),
          ],
        ),
      ),
    );
  }
}

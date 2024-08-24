import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';
import 'package:sahaj_dhan/utils/strings.dart';
import 'package:sahaj_dhan/utils/text_theme.dart';

class DealCard extends StatelessWidget {
  final Deal stockDeal;
  const DealCard({
    super.key,
    required this.stockDeal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.transparent,
          stockDeal.dealTradeType.textColor.withOpacity(0.7),
        ], stops: const [
          0.6,
          1.0,
        ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stockDeal.symbol ?? stockDeal.securityName,
                  style: TextUtil.subTitleTextBold,
                ),
                if (stockDeal.symbol != null) ...[
                  Opacity(
                    opacity: 0.72,
                    child: Text(
                      stockDeal.securityName,
                      style: TextUtil.subTitleText,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (stockDeal.clientName != null) ...[
                  Text(
                    "${stockDeal.clientName}",
                    style: TextUtil.subTitleText,
                  ),
                ],
                SizedBox(height: 2.h),
                Text(
                  stockDeal.tradeType,
                  style: TextUtil.subTitleTextBold
                      .copyWith(color: stockDeal.dealTradeType.textColor),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${Strings.rupee} ${stockDeal.tradePrice}",
                  style: TextUtil.subTitleTextBold,
                ),
                if (stockDeal.quantity != null) ...[
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "qtn. ${stockDeal.quantity}",
                      style: TextUtil.subTitleTextBold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingDealCard extends StatelessWidget {
  const LoadingDealCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.h, vertical: 5.h),
      height: 80.h,
      color: Colors.white.withOpacity(0.1),
    );
  }
}

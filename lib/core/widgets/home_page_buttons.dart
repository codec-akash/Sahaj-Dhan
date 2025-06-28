import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/widgets/button.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/screen/long_term_main.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/ui/stocks_filter.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/screen/top_investor_button.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/screen/top_investor_main.dart';

class HomePageButtons extends StatelessWidget {
  const HomePageButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Expanded(
                child: TopInvestorButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TopInvestorMain()));
                  },
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Button(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StocksFilterMain()));
                  },
                  title: "All Stocks List",
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

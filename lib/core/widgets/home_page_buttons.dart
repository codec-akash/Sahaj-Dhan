import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/navigation/navigation_service.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/core/widgets/button.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/screen/top_investor_button.dart';

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
                    di<NavigationService>()
                        .navigateTo(RouteConfig.topInvestors);
                  },
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Button(
                  onTap: () {
                    di<NavigationService>().navigateTo(RouteConfig.stocksList);
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

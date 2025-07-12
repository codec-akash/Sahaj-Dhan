import 'package:flutter/material.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/provider/long_term_page_provider.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/screen/long_term_main.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/screen/stocks_holding_investors.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/provider/stocks_list_page_provider.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/ui/home_screen.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/provider/top_investor_feature_provider.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/screen/investor_holdings/investor_holding_main.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/screen/top_investor_main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConfig.initial:
      case RouteConfig.longTerm:
        return MaterialPageRoute(
          builder: (_) => LongTermPageProvider(
            child: const LongTermMain(),
          ),
        );

      case RouteConfig.stocksList:
        return MaterialPageRoute(
          builder: (_) => StocksListPageProvider(
            child: const HomeScreen(),
          ),
        );

      case RouteConfig.topInvestors:
        return MaterialPageRoute(
          builder: (_) => TopInvestorFeatureProvider(
            child: const TopInvestorMain(),
          ),
        );

      case RouteConfig.stocksHoldingInvestors:
        return MaterialPageRoute(
          builder: (_) => TopInvestorFeatureProvider(
            child: StocksHoldingInvestors(
              stockName:
                  (settings.arguments as Map<String, dynamic>)['stockName'] ??
                      '',
              symbol:
                  (settings.arguments as Map<String, dynamic>)['symbol'] ?? '',
            ),
          ),
        );

      case RouteConfig.investorHolding:
        return MaterialPageRoute(
          builder: (_) => TopInvestorFeatureProvider(
            child: InvestorHoldingMain(
              investor:
                  (settings.arguments as Map<String, dynamic>)['investor'],
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}

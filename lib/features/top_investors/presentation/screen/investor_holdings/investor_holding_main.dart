import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/navigation/navigation_service.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/core/services/injection.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/core/types/stock_holding_type.dart';
import 'package:sahaj_dhan/core/utils/colors.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/screen/long_term_stock_card.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/investor_holding.dart';
import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/bloc/top_investor_bloc.dart';

class InvestorHoldingMain extends StatefulWidget {
  final TopInvestor investor;
  const InvestorHoldingMain({
    super.key,
    required this.investor,
  });

  static const String routeName = RouteConfig.investorHolding;

  @override
  State<InvestorHoldingMain> createState() => _InvestorHoldingMainState();
}

class _InvestorHoldingMainState extends State<InvestorHoldingMain> {
  InvestorMetrics? investorMetrics;

  List<StockHoldingType> stockHoldingTypes = [
    StockHoldingType.all,
    StockHoldingType.closed,
    StockHoldingType.open
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<TopInvestorBloc>()
          .add(LoadInvestorHoldings(widget.investor.clientName));
    });
    super.initState();
  }

  void updateTradeHistoryList(StockHoldingType stockHoldingType) {
    context.read<TopInvestorBloc>().add(LoadInvestorHoldings(
        widget.investor.clientName,
        holdingType: stockHoldingType.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.investor.clientName),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                di<NavigationService>().pop();
              },
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => stockHoldingTypes
                    .map(
                      (element) => PopupMenuItem(
                        value: element.value,
                        onTap: () {
                          updateTradeHistoryList(element);
                        },
                        child: Text(element.title),
                      ),
                    )
                    .toList(),
              )
            ],
            pinned: true,
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueGrey[200]!,
                      Colors.blueGrey[100]!,
                      Colors.white,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildStatRow(
                      "Avg. Profit Loss % - ",
                      investorMetrics?.avgProfitLossRatio.toString() ?? "",
                    ),
                    SizedBox(height: 8.h),
                    _buildStatRow(
                      "Loss Trades - ",
                      investorMetrics?.lossTrades.toString() ?? "",
                    ),
                    SizedBox(height: 8.h),
                    _buildStatRow(
                      "Profit Trades - ",
                      investorMetrics?.profitableTrades.toString() ?? "",
                    ),
                    SizedBox(height: 8.h),
                    _buildStatRow(
                      "Total Trades - ",
                      investorMetrics?.totalTrades.toString() ?? "",
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<TopInvestorBloc, TopInvestorState>(
            buildWhen: (previous, current) {
              if ((current is InvestorHoldingLoaded) ||
                  (current is TopInvestorLoadingState &&
                      (current.topInvestorEvent is LoadInvestorHoldings)) ||
                  (current is TopInvestorFailedState &&
                      (current.topInvestorEvent is LoadInvestorHoldings))) {
                return true;
              }
              return false;
            },
            listener: (context, state) {
              if (state is InvestorHoldingLoaded) {
                setState(() {
                  investorMetrics = state.investorHolding.investorMetrics;
                });
              }
            },
            builder: (context, state) {
              if (state is TopInvestorLoadingState) {
                return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator.adaptive()));
              }
              if (state is TopInvestorFailedState) {
                return SliverToBoxAdapter(
                    child:
                        Center(child: Text("Error State- ${state.message}")));
              }
              if (state is InvestorHoldingLoaded) {
                return SliverList.builder(
                  itemCount: state.investorHolding.investorHoldingData.length,
                  itemBuilder: (context, index) {
                    return LongTermStockCard(
                      longTermStocks:
                          state.investorHolding.investorHoldingData[index],
                      showClientName: false,
                    );
                  },
                );
              }
              return SliverToBoxAdapter(child: Text("Unknown Screen"));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String leftText, String rightText) {
    return Row(
      children: [
        Text(
          leftText,
          style: CustomTextTheme.text12.copyWith(
            color: AppColor.textColor.withOpacity(0.9),
          ),
        ),
        Text(
          rightText,
          style: CustomTextTheme.text12.copyWith(
            color: AppColor.textColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}

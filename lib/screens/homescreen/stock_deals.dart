import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_bloc.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_event.dart';
import 'package:sahaj_dhan/blocs/stocks_bloc/stock_state.dart';
import 'package:sahaj_dhan/models/stock_deal_model.dart';
import 'package:sahaj_dhan/screens/filters/stock_deal_more.dart';
import 'package:sahaj_dhan/screens/homescreen/deal_card.dart';
import 'package:sahaj_dhan/utils/app_color.dart';
import 'package:sahaj_dhan/utils/strings.dart';
import 'package:sahaj_dhan/utils/text_theme.dart';
import 'package:shimmer/shimmer.dart';

class StockDealMain extends StatefulWidget {
  const StockDealMain({super.key});

  @override
  State<StockDealMain> createState() => _StockDealMainState();
}

class _StockDealMainState extends State<StockDealMain> {
  List<Deal> stockDeals = [];
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StockBloc>().add(const LoadStockDeals());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Stock Overflow",
                style: TextUtil.headingText,
              ),
              SizedBox(height: 20.h),

              // SizedBox(height: 10.h),
              BlocListener<StockBloc, StockState>(
                listener: (context, state) {
                  if (state is StockStateLoading &&
                      state.currentEvent is LoadStockDeals) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is StockDealsLoaded) {
                    setState(() {
                      stockDeals = state.stockDeals;
                      isLoading = false;
                    });
                  }
                  if (state is StockStateFailed) {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }
                },
                child: Container(),
              ),
              if (isLoading == true) ...[
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) =>
                            const LoadingDealCard()),
                  ),
                )
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today's Deals", style: TextUtil.headingTitleText),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const StockDealMore()));
                      },
                      child: Text(
                        Strings.viewMore,
                        style: TextUtil.text14
                            .copyWith(color: AppColor.primaryColorDark),
                      ),
                    ),
                  ],
                ),
                if (stockDeals.isEmpty) ...[
                  const Text("No Deals to show")
                ] else ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: stockDeals.length,
                      itemBuilder: (context, index) =>
                          DealCard(stockDeal: stockDeals[index]),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

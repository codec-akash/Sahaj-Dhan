import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/core/widgets/home_page_buttons.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/ui/stock_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = RouteConfig.stocksList;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadInit();
    });
    super.initState();
  }

  void loadInit() {
    context.read<StocksBloc>().add(GetStockListEvent(page: 0));
    context.read<StocksBloc>().add(GetStockFilter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sahi Stocks"),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          Completer loadInitFuture = Completer<void>();
          loadInit();
          StreamSubscription? subscription;
          subscription = context.read<StocksBloc>().stream.listen((newState) {
            if (newState is StocksListLoaded || newState is StocksFailure) {
              loadInitFuture
                  .complete(); // Complete when data is loaded or failed
              subscription?.cancel(); // Stop listening
            }
          });
          return loadInitFuture.future;
        },
        child: Column(
          children: [
            HomePageButtons(),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  "Stocks Traded Today -",
                  style: CustomTextTheme.text16,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            BlocListener<StocksBloc, StocksState>(
              bloc: context.read<StocksBloc>(),
              listener: (context, state) {
                if (state is StocksFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: Container(),
            ),
            BlocBuilder<StocksBloc, StocksState>(
              buildWhen: (previous, current) {
                return current is StocksListLoaded ||
                    (current is StocksFailure &&
                        current.event is GetStockListEvent);
              },
              builder: (context, state) {
                if (state is StocksLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is StocksListLoaded) {
                  if (state.stocks.values.isEmpty) {
                    return Container();
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.stocks.values.elementAt(0).length,
                      itemBuilder: (context, idx) => StockCard(
                        stock: state.stocks.values.elementAt(0)[idx],
                      ),
                    ),
                  );
                }
                return Text(
                  "No State Found",
                  style: CustomTextTheme.text14.copyWith(color: Colors.amber),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

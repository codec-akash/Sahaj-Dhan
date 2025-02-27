import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/bloc/stocks_bloc.dart';
import 'package:sahaj_dhan/features/stocks_list/presentation/ui/stock_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    context.read<StocksBloc>().add(GetStockListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
        child: BlocConsumer<StocksBloc, StocksState>(
          listener: (context, state) {
            if (state is StocksFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is StocksLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is StocksListLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Stocks Traded Today -", style: CustomTextTheme.text16),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.stocks.length,
                      itemBuilder: (context, idx) => StockCard(
                        stock: state.stocks[idx],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Text(
              "No State Found",
              style: CustomTextTheme.text14.copyWith(color: Colors.amber),
            );
          },
        ),
      ),
    );
  }
}

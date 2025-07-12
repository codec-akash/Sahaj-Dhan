import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/extensions/context_extension.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/core/theme/theme_config.dart';
import 'package:sahaj_dhan/core/widgets/home_page_buttons.dart';
import 'package:sahaj_dhan/features/app_update/domain/entities/update_info.dart';
import 'package:sahaj_dhan/features/app_update/presentation/bloc/update_bloc.dart';
import 'package:sahaj_dhan/features/app_update/presentation/bloc/update_event.dart';
import 'package:sahaj_dhan/features/app_update/presentation/bloc/update_state.dart';
import 'package:sahaj_dhan/features/app_update/presentation/widgets/update_card.dart';
import 'package:sahaj_dhan/features/long_term_stocks/domain/entities/long_term_stocks.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/bloc/long_term_bloc.dart';
import 'package:sahaj_dhan/features/long_term_stocks/presentation/screen/long_term_stocks_datelist.dart';

class LongTermMain extends StatefulWidget {
  const LongTermMain({super.key});

  static const String routeName = RouteConfig.longTerm;

  @override
  State<LongTermMain> createState() => _LongTermMainState();
}

class _LongTermMainState extends State<LongTermMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // * fitlers and pagination
  int page = 0;
  bool isHistorical = false;
  bool? profitOnly;
  bool? highestSort;
  bool? monthWiseTrade;

  final ScrollController _scrollController = ScrollController();
  Map<String, List<LongTermStock>> longTermStocks = {};

  @override
  void initState() {
    context.read<UpdateBloc>().add(CheckForUpdate());
    super.initState();
    _loadHodlStocks();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _loadHodlStocks();
        }
      });
    });
  }

  void _loadHodlStocks() {
    page++;
    context.read<LongTermBloc>().add(GetLongTermStockListEvent(
          page: page,
          isHistorical: isHistorical,
          profitType: profitOnly,
          monthlySortType: monthWiseTrade,
          showHighestSort: highestSort,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sahi Stocks"),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       _scaffoldKey.currentState!.openEndDrawer();
        //     },
        //     icon: Icon(Icons.filter_alt_outlined),
        //   )
        // ],
      ),
      // endDrawer: FilterDrawer(
      //   openPositions: isHistorical,
      //   profitOnly: profitOnly,
      //   monthwiseTrade: monthWiseTrade,
      //   highest: highestSort,
      //   onApplyTap: (
      //       {highest,
      //       required isHistorical,
      //       profitOnly,
      //       tradeMonthWise}) async {
      //     setState(() {
      //       this.isHistorical = isHistorical;
      //       this.profitOnly = profitOnly;
      //       monthWiseTrade = tradeMonthWise;
      //       highestSort = highest;
      //       page = 0;
      //     });
      //     await _scrollController.animateTo(
      //       0,
      //       duration: Constant.duration500,
      //       curve: Curves.easeInOut,
      //     );
      //     _loadHodlStocks();
      //   },
      // ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          BlocBuilder<UpdateBloc, UpdateState>(
            builder: (context, state) {
              if (state is UpdateAvailable) {
                return SliverToBoxAdapter(
                  child: UpdateCard(
                    updateInfo: state.updateInfo,
                    onUpdate: () {
                      context.read<UpdateBloc>().add(StartUpdate());
                    },
                    onDismiss: () {
                      context.read<UpdateBloc>().add(DismissUpdate());
                    },
                  ),
                );
              }
              if (state is UpdateDownloading) {
                return SliverToBoxAdapter(
                  child: UpdateCard(
                    updateInfo: UpdateInfo(
                      currentVersion: '',
                      newVersion: '',
                      changelog: 'Downloading update...',
                      isUpdateAvailable: true,
                      downloadProgress: state.progress,
                      status: UpdateStatus.downloading,
                    ),
                    onUpdate: () {},
                    onDismiss: () {},
                  ),
                );
              }
              return SliverToBoxAdapter(child: const SizedBox.shrink());
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(child: HomePageButtons()),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          SliverToBoxAdapter(
            child: Text(
              "Stocks Added By Sharks Today",
              textAlign: TextAlign.center,
              style: CustomTextTheme.text16,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          BlocListener<LongTermBloc, LongTermState>(
            listener: (context, state) {
              if (state is LongTermListLoaded) {
                setState(() {
                  longTermStocks = state.longTermStocks;
                });
              }
              if (state is LongTermFailedState) {
                context.showSnackBar(title: state.message);
              }
            },
            child: SliverToBoxAdapter(),
          ),
          SliverList.builder(
            itemCount: longTermStocks.entries.length,
            itemBuilder: (context, index) => LongTermStocksDateList(
              date: longTermStocks.entries.elementAt(index).key,
              dateStocks: longTermStocks.entries.elementAt(index).value,
            ),
          ),
          BlocBuilder<LongTermBloc, LongTermState>(
            builder: (context, state) {
              if (state is LongTermLoadingState) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 50.h),
                      Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                );
              }
              return SliverToBoxAdapter();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

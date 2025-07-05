import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahaj_dhan/core/navigation/route_config.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/bloc/top_investor_bloc.dart';
import 'package:sahaj_dhan/features/top_investors/presentation/screen/top_investor_card.dart';

class TopInvestorMain extends StatefulWidget {
  const TopInvestorMain({super.key});

  static const String routeName = RouteConfig.topInvestors;

  @override
  State<TopInvestorMain> createState() => _TopInvestorMainState();
}

class _TopInvestorMainState extends State<TopInvestorMain> {
  @override
  void initState() {
    context.read<TopInvestorBloc>().add(LoadTopInvestors());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Investors"),
      ),
      body: BlocBuilder<TopInvestorBloc, TopInvestorState>(
        bloc: context.read<TopInvestorBloc>(),
        buildWhen: (previous, current) {
          if ((current is TopInvestorLoadedState) ||
              (current is TopInvestorLoadingState &&
                  (current.topInvestorEvent is LoadTopInvestors)) ||
              (current is TopInvestorFailedState &&
                  (current.topInvestorEvent is LoadTopInvestors))) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is TopInvestorLoadingState) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is TopInvestorLoadedState) {
            return ListView.separated(
              itemCount: state.topInvestors.length,
              itemBuilder: (context, index) =>
                  TopInvestorCard(topInvestor: state.topInvestors[index]),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
            );
          }

          if (state is TopInvestorFailedState) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}

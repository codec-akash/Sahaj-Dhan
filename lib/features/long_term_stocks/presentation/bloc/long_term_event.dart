part of 'long_term_bloc.dart';

class LongTermEvent extends Equatable {
  const LongTermEvent();

  @override
  List<Object?> get props => [];
}

class GetLongTermStockListEvent extends LongTermEvent {
  final int page;
  final bool isHistorical;
  final bool? profitType;
  final bool? monthlySortType;
  final bool? showHighestSort;
  const GetLongTermStockListEvent({
    required this.page,
    required this.isHistorical,
    this.profitType,
    this.monthlySortType,
    this.showHighestSort,
  });
}

part of 'long_term_bloc.dart';

class LongTermEvent extends Equatable {
  const LongTermEvent();

  @override
  List<Object?> get props => [];
}

class GetLongTermStockListEvent extends LongTermEvent {
  final bool isHistorical;
  final int page;
  const GetLongTermStockListEvent({
    required this.page,
    required this.isHistorical,
  });
}

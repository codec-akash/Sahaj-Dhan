part of 'long_term_bloc.dart';

class LongTermState extends Equatable {
  const LongTermState();

  @override
  List<Object?> get props => [];
}

class LongTermInitialState extends LongTermState {}

class LongTermLoadingState extends LongTermState {}

class LongTermFailedState extends LongTermState {
  final String message;

  const LongTermFailedState(this.message);
}

class LongTermListLoaded extends LongTermState {
  final List<LongTermStocks> longTermStocks;

  const LongTermListLoaded(this.longTermStocks);

  @override
  List<Object?> get props => [longTermStocks];
}

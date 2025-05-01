import 'package:equatable/equatable.dart';

class TopInvestor extends Equatable {
  final String clientName;
  final int profitableTrades;
  final String averageGainPercentage;
  final String highestGainPercentage;

  const TopInvestor({
    required this.clientName,
    required this.profitableTrades,
    required this.averageGainPercentage,
    required this.highestGainPercentage,
  });

  @override
  List<Object?> get props => [
        clientName,
        profitableTrades,
        averageGainPercentage,
        highestGainPercentage
      ];
}

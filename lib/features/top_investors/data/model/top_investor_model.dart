import 'package:sahaj_dhan/features/top_investors/domain/entities/top_investor.dart';

class TopInvestorModel extends TopInvestor {
  TopInvestorModel({
    required super.clientName,
    required super.profitableTrades,
    required super.averageGainPercentage,
    required super.highestGainPercentage,
  });

  factory TopInvestorModel.fromJson(Map<String, dynamic> json) {
    return TopInvestorModel(
      clientName: json['clientName'],
      profitableTrades: json['profitableTrades'],
      averageGainPercentage: json['averageGainPercentage'],
      highestGainPercentage: json['highestGainPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'profitableTrades': profitableTrades,
      'averageGainPercentage': averageGainPercentage,
      'highestGainPercentage': highestGainPercentage,
    };
  }
}

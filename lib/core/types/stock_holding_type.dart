import 'package:sahaj_dhan/core/utils/strings.dart';

enum StockHoldingType {
  all("all", Strings.all),
  closed('closed', Strings.closedTrades),
  open('open', Strings.openTrades);

  final String value;
  final String title;

  const StockHoldingType(this.value, this.title);
}

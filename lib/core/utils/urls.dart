class ApiUrl {
  static const String baseUrl = "https://stocksapi.mahakhumb.in/api/";
  static const String stockList = "stocks/deals";
  static const String filters = "stocks/filters";
  static const String longTermHolding = "stocks/long-term-holdings";
  static const String topInvestors = "stocks/top-investors";
  static const String investor = "investor";
  static String investorHolding(String clientName) => "investor/$clientName";
}

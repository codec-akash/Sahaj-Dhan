class Strings {
  static const String appName = "Sahaj Dhan";
  static const String rupee = '₹';
  static const String viewMore = 'view more';
}

class ApiUrls {
  // base url --
  static const String baseURL = "https://sahaj-backend.onrender.com";

  // end- points --
  static const String getBulkDeals =
      "/v1/bulk-deals?tradeTypes=BUY,SELL&skip=0&limit=20&executedAt.comparison=equals&executedAt.values=2024-08-07";
}

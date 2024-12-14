class Strings {
  static const String appName = "Sahaj Dhan";
  static const String rupee = '₹';
  static const String viewMore = 'view more';
}

class ApiUrls {
  // base url --
  // static const String baseURL = "https://api.stockoverflow.co.in";
  static const String baseURL = "http://192.168.1.4:3000/api";

  // end- points --
  static const String getBulkDeals = "/stocks/deals";
  // "/v1/bulk-deals?skip=0&limit=20&executedAt.comparison=equals&executedAt.values=2024-08-07";

  static const String getDealsFilter = "/stocks/filters";

  //User Api
  static const String sendUserToken = "/user/notification";
}

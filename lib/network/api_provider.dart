import 'package:sahaj_dhan/network/api_response_handler.dart';
import 'package:sahaj_dhan/network/client.dart';
import 'package:sahaj_dhan/utils/strings.dart';

class ApiProvider {
  Future<Map<String, dynamic>> get(String endPoint,
      {Map<String, dynamic>? queryParam}) async {
    String urlString = ApiUrls.baseURL + endPoint;
    Uri url = Uri.parse(urlString);

    Map<String, String> header = await _getHeaders();

    try {
      var response = await nonAuthedClient.get(url, params: queryParam);
      Map<String, dynamic> res = ApiResponseHandler.output(response);
      return res;
    } catch (e) {
      return ApiResponseHandler.outputError(urlString);
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      "Content-Type": "application/json; charset=utf-8",
    };

    return headers;
  }
}

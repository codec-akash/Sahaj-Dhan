import 'dart:convert';
import 'dart:developer' as develop;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:sahaj_dhan/utils/secure_storage.dart';
import 'package:sahaj_dhan/utils/strings.dart';

class AuthInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    var accessToken = await SecureStorage.getInstance().getAccessToken();
    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }
    request.headers['Content-Type'] = 'application/json';

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return true;
  }
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    develop.log(request.toString());

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    develop.log(
        "Response: ${response.statusCode}\n${response.headers}\n${response.contentLength}");
    develop
        .log("Request: ${response.request?.url}\n${response.request?.headers}");

    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return true;
  }
}

class TokenRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401) {
      final refreshToken = await SecureStorage.getInstance().getRefreshToken();
      if (refreshToken != null) {
        var response = await nonAuthedClient.post(
            Uri.parse('${ApiUrls.baseURL}/v1/users/refresh-token'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $refreshToken',
            });
        if (response.statusCode ~/ 100 == 2) {
          var json = jsonDecode(response.body);
          if (json case {"result": {"accessToken": String accessToken}}) {
            await SecureStorage.getInstance()
                .writeAccessToken(token: accessToken);
            return true;
          }
        }
      }
    }
    return super.shouldAttemptRetryOnResponse(response);
  }
}

final nonAuthedClient =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);

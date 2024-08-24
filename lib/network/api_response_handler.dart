import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiResponseHandler {
  static Map<String, dynamic> output(Response uriResponse) {
    Map<String, dynamic> res = <String, dynamic>{};

    if (uriResponse.statusCode == 200 || uriResponse.statusCode ~/ 100 == 2) {
      res['statusCode'] = uriResponse.statusCode;
      res['result'] = json.decode(uriResponse.body)['result'];
      res['error'] = null;
    } else if (uriResponse.statusCode ~/ 100 == 4) {
      res['statusCode'] = uriResponse.statusCode;
      res['result'] = null;
      res['error'] = jsonDecode(uriResponse.body);
    } else if (uriResponse.statusCode >= 400 && uriResponse.statusCode <= 500) {
      res['statusCode'] = uriResponse.statusCode;
      res['result'] = null;
      res['error'] = "something went wrong";
    } else {
      res['result'] = null;
      res['error'] = "something went wrong";
    }

    debugPrint("Response - $res");

    return res;
  }

  static Map<String, dynamic> outputError(String url) {
    Map<String, dynamic> res = <String, dynamic>{};
    res['result'] = null;
    res['error'] = "Something went wrong";

    debugPrint("Response url - $url error state - $res");

    return res;
  }
}

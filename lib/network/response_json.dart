import 'dart:convert';
import 'dart:developer' as develop;

import 'package:http/http.dart';

extension ResponseToJSON on Future<Response> {
  Future<dynamic> toJson() async {
    var res = await this;
    develop.log(res.body);
    if (res.statusCode ~/ 100 == 2) {
      return jsonDecode(res.body);
    } else {
      throw (res, jsonDecode(res.body));
    }
  }
}

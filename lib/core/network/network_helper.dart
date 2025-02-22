import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';

enum Method { get, post, put, patch, delete }

class ApiHelper {
  final Dio _dio;

  ApiHelper(this._dio);

  Future<Response> execute({
    required Method method,
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response? response;
      switch (method) {
        case Method.get:
          response = await _dio.get(url, queryParameters: queryParameters);
          break;
        case Method.post:
          response = await _dio.post(url, data: data);
          break;
        case Method.put:
          response = await _dio.put(url, data: data);
          break;
        case Method.patch:
          response = await _dio.patch(url);
          break;
        case Method.delete:
          response = await _dio.delete(url);
          break;
      }

      return _returnResponse(response);
    } on DioException catch (e) {
      return _returnResponse(e.response!);
    }
  }

  Response _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 400:
        throw BadRequestException(
            response.data["message"].toString(), response.statusCode!);
      case 401:
        throw UnauthorizedException(
            response.data["message"].toString(), response.statusCode!);
      case 403:
        throw ForbiddenException(
            response.data["message"].toString(), response.statusCode!);
      case 404:
        var res = jsonDecode(response.data);
        throw NotFoundException(
            res["message"].toString(), response.statusCode!);
      case 422:
        throw UnprocessableContentException(
            response.data["message"].toString(), response.statusCode!);
      case 500:
        throw InternalServerException(
            response.data["message"].toString(), response.statusCode!);
      default:
        throw ApiException(
          message: 'Error occured while Communication with Server',
          errorCode: response.statusCode ?? 505,
        );
    }
  }
}

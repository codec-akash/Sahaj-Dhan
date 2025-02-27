import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sahaj_dhan/core/errors/exceptions.dart';
import 'package:sahaj_dhan/core/network/api_client.dart';

enum Method { get, post, put, patch, delete }

class ApiHelper {
  final ApiClient apiClient;

  ApiHelper(this.apiClient);

  Dio get _dio => apiClient.dio;

  Future<Response> execute({
    required Method method,
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response;
      switch (method) {
        case Method.get:
          response = await _dio.get(url, queryParameters: queryParameters);
          break;
        case Method.post:
          response = await _dio.post(url,
              data: data, queryParameters: queryParameters);
          break;
        case Method.put:
          response =
              await _dio.put(url, data: data, queryParameters: queryParameters);
          break;
        case Method.patch:
          response = await _dio.patch(url,
              data: data, queryParameters: queryParameters);
          break;
        case Method.delete:
          response = await _dio.delete(url,
              data: data, queryParameters: queryParameters);
          break;
      }

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return _returnResponse(e.response!);
      } else {
        throw ApiException(
          message: 'Network error: ${e.message}',
          errorCode: 0,
        );
      }
    } catch (e) {
      throw ApiException(
        message: 'Unexpected error: $e',
        errorCode: -1,
      );
    }
  }

  Response _returnResponse(Response response) {
    final statusCode = response.statusCode ?? 500;
    final responseData =
        response.data is String ? jsonDecode(response.data) : response.data;
    final errorMessage = responseData is Map
        ? responseData["message"]?.toString()
        : 'Unknown error';

    switch (statusCode) {
      case 200:
      case 201:
        return response;
      case 400:
        throw BadRequestException(errorMessage ?? 'Bad Request', statusCode);
      case 401:
        throw UnauthorizedException(errorMessage ?? 'Unauthorized', statusCode);
      case 403:
        throw ForbiddenException(errorMessage ?? 'Forbidden', statusCode);
      case 404:
        throw NotFoundException(errorMessage ?? 'Not Found', statusCode);
      case 422:
        throw UnprocessableContentException(
            errorMessage ?? 'Unprocessable Content', statusCode);
      case 500:
        throw InternalServerException(
            errorMessage ?? 'Internal Server Error', statusCode);
      default:
        throw ApiException(
          message:
              errorMessage ?? 'Error occurred while communicating with server',
          errorCode: statusCode,
        );
    }
  }
}

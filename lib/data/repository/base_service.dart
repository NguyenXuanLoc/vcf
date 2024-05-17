import 'dart:convert';

import 'package:base_bloc/utils/log_utils.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../generated/locale_keys.g.dart';
import '../../utils/connection_utils.dart';
import '../globals.dart' as globals;
import 'api_result.dart';

class BaseService {
  var baseUrl = 'https://vcf.novatic.com.vn/api/v1/';

  void initProvider() {}

  // ignore: non_constant_identifier_names
  Future<ApiResult> GET_WITH_HTTP_LIB(String url,
      {Map<String, dynamic>? jsonParam,
      bool isNewFormat = false,
      String baseUrl = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[GET] ${this.baseUrl}$url');
    debugPrint("Bearer ${globals.accessToken}");
    debugPrint("BODY ${jsonParam != null ? json.encode(jsonParam) : ''}");
    try {
      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.accessToken}'
      };
      var request = http.Request('GET', Uri.parse(this.baseUrl + url));
      request.body = json.encode(jsonParam);
      request.headers.addAll(header);
      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.bytesToString();
      Logger().d(responseData);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseData != null) {
        var result = json.decode(responseData);
        return ApiResult<dynamic>(
            data: isNewFormat ? result : result['data'],
            statusCode: response.statusCode);
      } else {
        Logger().e('Error ${response.statusCode} }');
        var result = json.decode(responseData);
        return ApiResult<dynamic>(
          error: result["message"] ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  Future<ApiResult> POST_WITH_MULTI_PATH_REQUEST_HTTP_LIB(String url,
      {required Map<String, dynamic> jsonParam}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[POST] ${this.baseUrl}$url');
    debugPrint("Bearer ${globals.accessToken}");
    debugPrint("BODY ${jsonParam != null ? json.encode(jsonParam) : ''}");
    try {
      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.accessToken}'
      };
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));
      request.files.add(await http.MultipartFile.fromPath(
          jsonParam.keys.first, jsonParam.values.first));
      request.headers.addAll(header);
      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.bytesToString();
      Logger().d(responseData);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseData != null) {
        var result = json.decode(responseData);
        return ApiResult<dynamic>(
            data: result['data'], statusCode: response.statusCode);
      } else {
        Logger().e('Error ${response.statusCode} }');
        var result = json.decode(responseData);
        return ApiResult<dynamic>(
          error: result["message"] ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> GET(String url,
      {Map<String, dynamic>? jsonParam,
      bool isNewFormat = false,
      String baseUrl = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[GET] ${this.baseUrl}$url');
    debugPrint("Bearer ${globals.accessToken}");
    debugPrint("BODY ${jsonParam != null ? json.encode(jsonParam) : ''}");
    try {
      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.accessToken}'
      };
      final response = await Dio()
          .get(this.baseUrl + url,
              options: Options(headers: header))
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            message: result['message'],
            data: result['data'],
            statusCode: response.statusCode);
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  Future<ApiResult> PATCH(String url, dynamic body) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[PATCH] ${baseUrl!}$url');
    debugPrint('[PARAMS] $body');
    debugPrint("Bearer ${globals.accessToken}");
    debugPrint("Language ${globals.lang}");

    try {
      final response = await Dio()
          .patch(
            url,
            data: body,
            options: Options(headers: {
              'Authorization': 'Bearer ${globals.accessToken}',
              'Content-Type': 'application/json',
            }),
          )
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            message: result['message'],
            data: result['data'],
            statusCode: response.statusCode);
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> POST(String url, dynamic body,
      {String baseUrl = '',
      String token = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[POST] ' + this.baseUrl + url);
    debugPrint("Bearer " + (token.isNotEmpty ? token : globals.accessToken));
    debugPrint('[PARAMS] ' +
        (body is FormData ? "${body.boundary}" : json.encode(body)));
    try {
      var headers = {
        'Authorization':
            'Bearer ${token.isNotEmpty ? token : globals.accessToken}',
        'Content-Type': 'application/json',
      };

      final response = await Dio()
          .post(this.baseUrl + url,
              data: body is FormData ? body : json.encode(body),
              options: Options(headers: headers))
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            message: result['message'],
            data: result['data'],
            statusCode: response.statusCode);
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      logE("TAG ERROR: ${exception.response?.data['message']}");
      return ApiResult<dynamic>(
          error: exception.response?.data['message'] ??
              LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> PUT(String url, dynamic body,
      {String baseUrl = '', bool isNewFormat = false}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[PUT] ' + this.baseUrl + url);
    debugPrint('[PARAMS] ' + json.encode(body));
    debugPrint('Bearer ${globals.accessToken}');
    try {
      final response = await Dio()
          .put(this.baseUrl + url,
              data: json.encode(body),
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${globals.accessToken}',
                  'Content-Type': 'application/json',
                },
              ))
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            message: result['message'],
            data: result['data'],
            statusCode: response.statusCode);
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response} ${exception}');
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> DELETE(String url, {String baseUrl = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    if (kDebugMode) {
      debugPrint('[DELETE] ${baseUrl!}$url');
    }
    try {
      final response = await Dio()
          .delete(url,
              options: Options(headers: {
                'Authorization': 'Bearer ${globals.accessToken}',
              }))
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            message: result['message'],
            data: result['data'],
            statusCode: response.statusCode);
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }
}

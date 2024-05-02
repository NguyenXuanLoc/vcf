import 'dart:convert';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/repository/api_result.dart';
import 'package:base_bloc/data/repository/base_service.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:dio/dio.dart';

class BaseRepository extends BaseService {
  static BaseRepository instance = BaseRepository._init();

  factory BaseRepository() {
    return instance;
  }

  BaseRepository._init();

  Future<ApiResult> registerWithEmail(String email, String pass) async =>
      POST('register', {ApiKey.email: email, ApiKey.password: pass});

  Future<ApiResult> loginWithEmail(String email, String pass) async =>
      POST('login', {ApiKey.email: email, ApiKey.password: pass});

  Future<ApiResult> getAthleteFilter(
          {int nextPage = 1, String gender = ApiKey.other}) async {
    return GET("athletes/filters?page=$nextPage", jsonParam: {
      ApiKey.gender: gender.isNotEmpty ? gender : ApiKey.other,
      ApiKey.is_feature_athlete: true
    });
  }

  Future<ApiResult> getAthlete({int nextPage = 1}) async {

    return GET("athletes?page=$nextPage");
  }

  Future<ApiResult> getUserProfile() async => GET('me');
}

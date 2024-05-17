import 'dart:convert';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/repository/api_result.dart';
import 'package:base_bloc/data/repository/base_service.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:dio/dio.dart';

class BaseRepository extends BaseService {
  static BaseRepository instance = BaseRepository._init();

  factory BaseRepository() {
    return instance;
  }

  BaseRepository._init();

  Future<ApiResult> registerWithEmail(
          String email, String pass, String fullName) async =>
      POST('register', {
        ApiKey.email: email,
        ApiKey.password: pass,
        ApiKey.full_name: fullName
      });

  Future<ApiResult> loginWithEmail(String email, String pass) async =>
      POST('login', {ApiKey.email: email, ApiKey.password: pass});

  Future<ApiResult> getAthleteFilter(
      {int nextPage = 1, String gender = ApiKey.other}) async {
    return GET_WITH_HTTP_LIB("athletes/filters?page=$nextPage", jsonParam: {
      ApiKey.gender: gender.isNotEmpty ? gender : ApiKey.other,
      // ApiKey.is_feature_athlete: true
    });
  }

  Future<ApiResult> getRaceFilter({int nextPage = 1, List<int?>? ids}) async {
    return POST("city/races?page=$nextPage",
        {ApiKey.location: ids, ApiKey.parent_race_id: 0});
  }

  Future<ApiResult> getAthlete({int nextPage = 1}) async {
    return GET("athletes?page=$nextPage");
  }

  Future<ApiResult> getRace({int nextPage = 1}) async =>
      GET_WITH_HTTP_LIB("races/filters?page=$nextPage",
          jsonParam: {ApiKey.parent_race_id: 0});

  Future<ApiResult> getPost({int nextPage = 1}) async =>
      GET("posts?page=$nextPage");

  Future<ApiResult> getUserProfile() async => GET('me');

  Future<ApiResult> getRaceDetailById(int id) async => GET('race/$id');

  Future<ApiResult> getAthleteDetailById(int id) async => GET('athlete/$id');

  Future<ApiResult> getNewsDetailById(String slug) async => GET('posts/$slug');

  Future<ApiResult> getCity() async => GET('city');

  Future<ApiResult> forgotPass(String email) async =>
      POST('password/forgot', {ApiKey.email: email});

  Future<ApiResult> updateProfile(
      {required String email,
      required String fullName,
      required String phone,
      String? newPass}) async {
    var body = {
      ApiKey.email: email,
      ApiKey.first_name: fullName,
      ApiKey.phone: phone
    };
    if (newPass != null && newPass.isNotEmpty) body[ApiKey.password] = newPass;
    return await PUT('me', body);
  }

  Future<ApiResult> uploadAvatar(String path) async {
    var compressPath = await Utils.compressFile(path);
    return await POST_WITH_MULTI_PATH_REQUEST_HTTP_LIB('update/avatar',
        jsonParam: {'avatar': compressPath ?? path});
  }
}

import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

import '../config/constant.dart';

class StorageUtils {
  static Future<void> saveLogin(String token, {bool isRefresh = false}) async {
    await GetStorage().write(StorageKey.token, token);
    isLogin = true;
    accessToken = token;
  }

  static Future<void> saveUserModel(UserModel model) async {
    userModel = model;
    GetStorage().write(StorageKey.userModel, model.toJson());
  }

  static Future<void> logout() async {
    await GetStorage().remove(StorageKey.token);
    isLogin = false;
  }

  static Future<void> getLogin() async {
    var token = await GetStorage().read(StorageKey.token);
    if (token != null) {
      isLogin = true;
      accessToken = token;
    }
    var userStr = await GetStorage().read(StorageKey.userModel);
    if (userStr != null) {
      userModel = UserModel.fromJson(userStr);
    }
  }

  static Future<UserModel?> getUserInfo() async {
    var userStr = await GetStorage().read(StorageKey.userModel);
    if (userStr != null) {
      return UserModel.fromJson(userStr);
    }
    return null;
  }
}

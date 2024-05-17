import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/user_model.dart';
import 'package:get_storage/get_storage.dart';

import '../config/constant.dart';

class StorageUtils {
  static Future<void> saveLogin(String token, String email, String pass,
      {bool isRefresh = false}) async {
    await GetStorage().write(StorageKey.token, token);
    await GetStorage().write(StorageKey.email, email);
    await GetStorage().write(StorageKey.pass, pass);
    isLogin = true;
    accessToken = token;
    // accessToken = '1|tfYZ0F8YtHt7gDbkjtFIm3n0uplmCl9r1i2TRBzL95b3a5dd' /*token*/;
  }

  static Future<void> saveUserModel(UserModel model) async {
    userModel = model;
    await GetStorage().write(StorageKey.userModel, model.toJson());
  }

  static Future<void> logout() async {
    await GetStorage().remove(StorageKey.token);
    await GetStorage().remove(StorageKey.email);
    await GetStorage().remove(StorageKey.userModel);
    await GetStorage().remove(StorageKey.pass);
    userModel = null;
    isLogin = false;
  }

  static Future<String> getOldPass() async {
    return await GetStorage().read(StorageKey.pass);
  }

  static void saveOldPass(String value) async {
    return await GetStorage().write(StorageKey.pass, value);
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

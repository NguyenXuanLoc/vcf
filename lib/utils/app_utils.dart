import 'package:base_bloc/data/repository/base_repository.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/globals.dart' as globals;
import '../data/model/user_model.dart';

class Utils {
  static var eventBus = EventBus();
  static const platform = MethodChannel('plugins.flutter.io/navigator');
  static var repository = BaseRepository();

  static fireEvent(dynamic model) => eventBus.fire(model);

  static bool validatePassword(String value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static void hideKeyboard(BuildContext? context) {
    if (context != null) FocusScope.of(context).requestFocus(FocusNode());
  }

  static void openUrl(String url,
      {LaunchMode launchMode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: launchMode);
    }
  }

  static String formatMoney(int? money) =>
      NumberFormat('#,###,###,#,###,###,###', 'vi').format(money ?? 0) + " VNĐ";

  static String formatDateFromAToB(DateTime from, DateTime to) =>
      DateFormat('dd').format(from) + "-" + DateFormat('dd.MM.yyyy').format(to);

  static String formatDateToddMMYYYY(DateTime date) =>
      DateFormat('dd.MM.yyyy').format(date);

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{9,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static Future<void> getUserInfo() async {
    if (globals.isLogin && globals.userModel == null) {
      var response = await repository.getUserProfile();
      if (response.error == null) {
        var userModel = UserModel.fromJson(response.data);
        StorageUtils.saveUserModel(userModel);
      }
    }
  }
}

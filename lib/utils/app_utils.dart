import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static var eventBus = EventBus();
  static const platform = MethodChannel('plugins.flutter.io/navigator');

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
      NumberFormat('#,###,###,#,###,###,###', 'vi').format(money ?? 0);
}

import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';

import '../base/hex_color.dart';

class Dialogs {
  static final GlobalKey<State> _keyLoader =
      GlobalKey<State>(debugLabel: "DEBUG KEY");

  static Future<void>? showLoadingDialog(BuildContext? context) {
    if (context == null) {
      return null;
    }
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: _keyLoader,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: colorTransparent,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor('25C869')),
                  ),
                )
              ],
            ),
          );
        });
  }

  static Future<void> hideLoadingDialog() async {
    try {
      await Future.delayed(
          const Duration(milliseconds: 200),
          () => Navigator.of(_keyLoader.currentContext!, rootNavigator: true)
              .pop());
    } catch (ex) {}
  }

  static Widget line(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      height: 2,
      color: HexColor('E8E8E8'));

  static Widget space({double? height}) => SizedBox(height: height ?? 15);
}

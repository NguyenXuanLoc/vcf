import 'dart:async';

import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_bar_widget.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';
import '../theme/app_styles.dart';
import '../utils/connection_utils.dart';

class AppNotDataWidget extends StatefulWidget {
  final String? message;
  final VoidCallback? onClick;
  final bool isScroll;
  final bool isStack;

  const AppNotDataWidget(
      {Key? key,
      this.message,
      this.onClick,
      this.isScroll = true,
      this.isStack = false})
      : super(key: key);

  @override
  State<AppNotDataWidget> createState() => _AppNotDataWidgetState();
}

class _AppNotDataWidgetState extends State<AppNotDataWidget> {
  String? message;
  var isInternet = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isStack
        ? Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
                text: message ?? LocaleKeys.network_error.tr(),
                style: typoSmallTextRegular.copyWith(color: colorWhite),
                children: []))
        : Stack(children: [
            if (widget.isScroll)
              ListView(physics: const AlwaysScrollableScrollPhysics()),
            Center(
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: message ?? LocaleKeys.network_error.tr(),
                        style:
                            typoW400.copyWith(fontSize: 14, color: colorWhite),
                        children: const [])))
          ]);
  }

  void buttonOnClick(BuildContext context) async {
    if (await ConnectionUtils.isConnect() == true) {
      widget.onClick?.call();
    }
  }
}

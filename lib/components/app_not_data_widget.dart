import 'dart:async';

import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_bar_widget.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/localization/locale_keys.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      this.isStack = true})
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
                text: message,
                style: typoSmallTextRegular.copyWith(),
                children: [
                  if (!isInternet) const TextSpan(text: "\n"),
                  if (!isInternet)
                    WidgetSpan(
                        child: Material(
                      color: colorTransparent,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Ink(
                            decoration: BoxDecoration(
                                color: HexColor('25C769'),
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, top: 7, bottom: 7),
                                    child: AppText(
                                      LocaleKeys.retry.tr(),
                                      style: typoW400.copyWith(
                                          fontSize: 14, color: colorWhite),
                                    )),
                                onTap: () => buttonOnClick(context))),
                      ),
                    ))
                ]))
        : Stack(children: [
            if (widget.isScroll)
              ListView(physics: const AlwaysScrollableScrollPhysics()),
            Center(
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: '$message\n',
                        style: typoSmallTextRegular.copyWith(),
                        children: [
                          if (!isInternet)
                            WidgetSpan(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Ink(
                                decoration: BoxDecoration(
                                    color: HexColor('25C769'),
                                    borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 25,
                                            right: 25,
                                            top: 7,
                                            bottom: 7),
                                        child: AppText(
                                          LocaleKeys.retry.tr(),
                                          style: typoW400.copyWith(
                                              fontSize: 14, color: colorWhite),
                                        )),
                                    onTap: () => buttonOnClick(context)),
                              ),
                            ))
                        ])))
          ]);
  }

  void buttonOnClick(BuildContext context) async {
    if (await ConnectionUtils.isConnect() == true) {
      widget.onClick?.call();
    }
  }
}

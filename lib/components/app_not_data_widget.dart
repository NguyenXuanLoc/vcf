import 'package:base_bloc/theme/colors.dart';
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

  void checkConnection() async {
    if (await ConnectionUtils.isConnect() == false) {
      message = LocaleKeys.network_error;
      isInternet = false;
      setState(() {});
    } else {
      message = widget.message ?? LocaleKeys.Not_data_please_try_again;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isStack
        ? Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
                text: (message ?? LocaleKeys.Not_data_please_try_again).tr(),
                style: typoSmallTextRegular.copyWith(color: colorWhite),
                children: []))
        : Stack(children: [
            if (widget.isScroll)
              ListView(physics: const AlwaysScrollableScrollPhysics()),
            Center(
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: message ??
                            LocaleKeys.Not_data_please_try_again.tr(),
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

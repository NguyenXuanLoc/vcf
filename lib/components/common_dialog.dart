import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_text.dart';

class CommonDialog extends StatelessWidget {
  final VoidCallback okOnClick;
  final String title;

  const CommonDialog({Key? key, required this.okOnClick, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: colorTransparent,
        child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17), color: colorWhite),
            padding: const EdgeInsets.only(top: 15),
            child: Column(children: [
              space(height: 7),
              AppText(title,
                  style: typoW400.copyWith(fontSize: 14),
                  textAlign: TextAlign.center),
              space(height: 15),
              Container(height: 0.4, color: colorPrimaryBrand100),
              Row(children: [
                buttonWidget(context, LocaleKeys.yess.tr(), 14, () {
                  Navigator.pop(context);
                  okOnClick.call();
                }),
                Container(height: 45, width: 0.4, color: colorPrimaryBrand100),
                buttonWidget(context, LocaleKeys.close.tr(), 14, () {
                  Navigator.pop(context);
                })
              ])
            ])));
  }

  Widget buttonWidget(BuildContext context, String title, double fontSize,
          VoidCallback onPress) =>
      Expanded(
          child: InkWell(
              highlightColor: colorTransparent,
              splashColor: colorTransparent,
              onTap: () => onPress.call(),
              child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: AppText(title,
                      style: typoW600.copyWith(
                          fontSize: fontSize, color: colorPrimaryBrand100)))));

  Widget space({double? height}) => SizedBox(height: height ?? 30);
}

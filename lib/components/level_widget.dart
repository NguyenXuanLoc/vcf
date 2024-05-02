import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../base/hex_color.dart';
import '../generated/locale_keys.g.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_text.dart';

class LevelWidget extends StatelessWidget {
  final int level;
  final bool isPaddingBigger;
  final bool isSmallText;

  const LevelWidget(
      {super.key,
      required this.level,
      this.isPaddingBigger = false,
      this.isSmallText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: isPaddingBigger
            ? const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3)
            : const EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
        decoration: BoxDecoration(
            color: HexColor("DB241D"), borderRadius: BorderRadius.circular(2)),
        child: AppText("${LocaleKeys.Top.tr()}: ${level}",
            style: typoW400.copyWith(
                fontSize: isSmallText ? 8 : 12, color: colorWhite)));
  }
}

import 'package:base_bloc/components/level_widget.dart';
import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/hex_color.dart';
import '../data/globals.dart';
import '../gen/assets.gen.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_network_image.dart';
import 'app_text.dart';

class ItemOtherAthleteWidget extends StatelessWidget {
  final VoidCallback itemOnClick;
  final AthleteModel model;

  const ItemOtherAthleteWidget(
      {super.key, required this.model, required this.itemOnClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: InkWell(
        onTap: () => itemOnClick.call(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 2.6,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                        aspectRatio: 120 / 80,
                        child: AppNetworkImage(source: model.photo)))),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                      "${model.firstName ?? ""} ${model.middleName ?? ""} ${model.lastName ?? ""}",
                      maxLine: 2,
                      style:
                          typoW500.copyWith(color: colorWhite, fontSize: 18)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LevelWidget(level: model.score ?? 0),
                      const SizedBox(width: 6),
                      Expanded(
                          child: AppText(
                              "${model.birthDate} ${LocaleKeys.Age.tr()}, ${model.city}",
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                              style: typoW500.copyWith(
                                  fontSize: 10,
                                  color: colorWhite.withOpacity(0.7))))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemWidget(String title, String content, {bool isBackIcon = false}) =>
      Padding(
        padding: const EdgeInsets.only(top: 2.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppText("$title: ",
                style: typoW600.copyWith(
                    fontSize: 12, color: colorWhite.withOpacity(0.5))),
            Expanded(
                child: AppText(content,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                    style: typoW500.copyWith(
                        fontSize: 10, color: colorWhite.withOpacity(0.5)))),
            if (isBackIcon) SvgPicture.asset(Assets.svg.icBackRight)
          ],
        ),
      );
}

import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_text.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/hex_color.dart';
import '../utils/app_utils.dart';

class ItemTopAthleteWidget extends StatelessWidget {
  final VoidCallback itemOnClick;
  final AthleteModel model;
  final int index;

  const ItemTopAthleteWidget(
      {super.key,
      required this.itemOnClick,
      required this.model,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => itemOnClick.call(),
      child: Container(
          padding: EdgeInsets.only(
              top: 10, bottom: 10, left: contentPadding, right: contentPadding),
          color: index % 2 == 0 ? HexColor("091A3A") : HexColor("11203D"),
          child: Row(children: [
            AppText("$index",
                style: typoW300.copyWith(fontSize: 12, color: colorWhite)),
            const SizedBox(width: 15),
            SizedBox(
                height: 50,
                width: 40,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: AppNetworkImage(
                        source:
                            ConstantKey.BASE_IMAGE_URL + (model.photo ?? '')))),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  AppText(
                      "${model.firstName ?? ""} ${model.middleName ?? ""} ${model.lastName ?? ""}",
                      maxLine: 1,
                      style:
                          typoW700.copyWith(fontSize: 12, color: colorWhite)),
                  const SizedBox(height: 3),
                  AppText(
                      "${Utils.getAgeByBirthDay(model.birthDate)} ${LocaleKeys.Age.tr()} ${model.city ?? ''}",
                      style: typoW400.copyWith(fontSize: 10, color: colorWhite),
                      maxLine: 1)
                ])),
            GradientText("${model.score ?? 0} ",
                style: typoW700.copyWith(fontSize: 12)),
            GradientText(LocaleKeys.Point.tr(),
                style: typoW300.copyWith(fontSize: 12))
          ])),
    );
  }
}

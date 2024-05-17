import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/level_widget.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../gen/assets.gen.dart';

class ItemAthleteWidget extends StatelessWidget {
  final AthleteModel model;
  final VoidCallback itemOnClick;

  const ItemAthleteWidget(
      {super.key, required this.model, required this.itemOnClick});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 1.85;
    return Padding(
      padding: EdgeInsets.only(right: contentPadding),
      child: InkWell(
        onTap: () => itemOnClick.call(),
        splashColor: colorTransparent,
        hoverColor: colorTransparent,
        highlightColor: colorTransparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: width,
                height: width * 1.2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: AppNetworkImage(
                      source: ConstantKey.BASE_IMAGE_URL + (model.photo ?? '')),
                )),
            Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color: HexColor("07183A"),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                width: width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                          "${model.firstName ?? ""} ${model.middleName ?? ""} ${model.lastName ?? ""}",
                          style: typoW700.copyWith(
                              fontSize: 14, color: colorWhite)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          LevelWidget(
                              level: model.score ?? 1,
                              isPaddingBigger: true,
                              isSmallText: true),
                          const SizedBox(width: 7),
                          AppText(
                            "${Utils.getAgeByBirthDay(model.birthDate)} ${LocaleKeys.Age.tr()}",
                            style: typoW400.copyWith(
                                fontSize: 8,
                                color: colorWhite.withOpacity(0.8)),
                          ),
                          const Spacer(),
                          SvgPicture.asset(Assets.svg.icBackRight)
                        ],
                      )
                    ]))
          ],
        ),
      ),
    );
  }
}

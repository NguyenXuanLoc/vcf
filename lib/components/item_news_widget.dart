import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/news_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/hex_color.dart';
import '../gen/assets.gen.dart';
import '../generated/locale_keys.g.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import '../utils/app_utils.dart';
import 'app_network_image.dart';
import 'app_text.dart';
import 'distance_widget.dart';

class ItemNewsWidget extends StatelessWidget {
  final NewsModel model;
  final VoidCallback itemOnClick;

  const ItemNewsWidget(
      {super.key, required this.model, required this.itemOnClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>itemOnClick.call(),
      child: Container(
        padding: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: HexColor("061739")),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(alignment: Alignment.bottomLeft, children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                              aspectRatio: 152 / 102,
                              child: AppNetworkImage(source: model.poster)))),
                  Container(
                      margin: const EdgeInsets.only(left: 7, bottom: 7),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: HexColor('DB241D')),
                      child: AppText(Utils.formatDateToddMMYYYY(model.dateTime),
                          style: typoW400.copyWith(
                              fontSize: 8, color: colorWhite))),
                ]),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: contentPadding),
                      AppText(model.name,
                          maxLine: 2,
                          style: typoW500.copyWith(
                              color: colorWhite, fontSize: 18)),
                      itemWidget(LocaleKeys.Donors.tr(), model.donors),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(bottom: contentPadding),
                child: SvgPicture.asset(Assets.svg.icBackRight)),
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

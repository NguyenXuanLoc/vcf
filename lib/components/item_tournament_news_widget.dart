import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/model/tournament_model.dart';
import '../gen/assets.gen.dart';
import 'distance_widget.dart';

class ItemTournamentNewsWidget extends StatelessWidget {
  final TournamentModel model;
  final VoidCallback itemOnClick;

  const ItemTournamentNewsWidget(
      {super.key, required this.model, required this.itemOnClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => itemOnClick.call(),
      child: Container(
        padding: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: HexColor("061739")),
        child: Row(
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                          aspectRatio: 152 / 102,
                          child: AppNetworkImage(source: model.poster)))),
              DistanceWidget(distance: model.distance, isMargin: true),
            ]),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(model.name,
                      style:
                          typoW500.copyWith(color: colorWhite, fontSize: 18)),
                  itemWidget(LocaleKeys.Place.tr(), model.address),
                  itemWidget(LocaleKeys.DateTime.tr(),
                      Utils.formatDateFromAToB(model.dateTime, model.dateTime)),
                  itemWidget(LocaleKeys.Participation_fee.tr(),
                      Utils.formatMoney(model.price)),
                  itemWidget(LocaleKeys.Donors.tr(), model.donors,
                      isBackIcon: true),
                ],
              ),
            )
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

import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_button.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/tournament_model.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../gen/assets.gen.dart';
import '../utils/app_utils.dart';
import 'distance_widget.dart';

class ItemTournamentWidget extends StatelessWidget {
  final TournamentModel model;
  final VoidCallback itemOnClick;

  const ItemTournamentWidget(
      {super.key, required this.model, required this.itemOnClick});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 1.85;
    return Padding(
        padding: EdgeInsets.only(right: contentPadding),
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => itemOnClick.call(),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                    width: width,
                    height: width * 0.67,
                    child: Stack(alignment: Alignment.bottomLeft, children: [
                      Positioned.fill(
                          child: AppNetworkImage(source: model.poster)),
                      Positioned.fill(
                          child: SvgPicture.asset(
                              Assets.svg.icOverlayTournament,
                              fit: BoxFit.cover)),
                      Padding(
                          padding: EdgeInsets.only(
                              left: contentPadding, bottom: contentPadding),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DistanceWidget(distance: model.distance),
                                space(),
                                AppText(model.name,
                                    maxLine: 1,
                                    style: typoW700.copyWith(
                                        fontSize: 12, color: colorWhite)),
                                space(),
                                AppText(
                                    Utils.formatDateFromAToB(
                                        model.dateTime, model.dateTime),
                                    style: typoW400.copyWith(
                                        fontSize: 9, color: colorWhite))
                              ]))
                    ])))));
  }

  Widget space() => const SizedBox(height: 3);
}

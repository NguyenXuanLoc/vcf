import 'package:flutter/cupertino.dart';

import '../base/hex_color.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import 'app_text.dart';

class DistanceWidget extends StatelessWidget {
  final int distance;
  final bool isMargin;

  const DistanceWidget(
      {super.key, required this.distance, this.isMargin = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: isMargin ? const EdgeInsets.only(left: 7, bottom: 7) : null,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
                colors: [HexColor("38BAEA"), HexColor("4869F0")],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: AppText("$distance km",
            style: typoW400.copyWith(fontSize: 8, color: colorWhite)));
  }
}

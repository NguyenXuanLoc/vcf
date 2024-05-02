import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../gen/assets.gen.dart';

class BikeCircleBackGroundWidget extends StatelessWidget {
  const BikeCircleBackGroundWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      Opacity(opacity: 0.03, child: SvgPicture.asset(Assets.svg.icBikeCircle));
}

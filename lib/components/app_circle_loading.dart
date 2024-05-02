import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/hex_color.dart';
import '../theme/colors.dart';

class AppCircleLoading extends StatelessWidget {
  final bool isCenter;
  final double? height;

  const AppCircleLoading({Key? key, this.isCenter = true, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: isCenter ? Alignment.center : null,
      child: Container(
          alignment: isCenter ? Alignment.center : null,
          width: 24,
          height: 24,
          child: const CircularProgressIndicator(
              color: colorWhite, strokeWidth: 2.0)),
    );
  }
}

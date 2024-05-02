import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/hex_color.dart';

class GradientButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Decoration? decoration;
  final VoidCallback onTap;
  final VoidCallback? onDoubleTab;
  final VoidCallback? onLongPress;
  final Widget widget;
  final BorderRadius? borderRadius;
  final bool isCenter;
  final EdgeInsetsGeometry? padding;

  const GradientButton(
      {Key? key,
      this.padding,
      this.onDoubleTab,
      this.onLongPress,
      this.height,
      this.width,
      this.decoration,
      required this.onTap,
      this.isCenter = false,
      required this.widget,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: colorTransparent,
        child: Ink(
            height: height ?? 48,
            width: width,
            decoration: decoration ??
                BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [HexColor('38BAEA'), HexColor('4869F0')])),
            child: InkWell(
                onDoubleTap: onDoubleTab,
                onTap: onTap,
                onLongPress: onLongPress,
                borderRadius: borderRadius,
                child: Container(
                    alignment: isCenter ? Alignment.center : null,
                    padding: padding,
                    child: widget))));
  }
}

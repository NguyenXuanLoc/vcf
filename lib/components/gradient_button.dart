import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Decoration decoration;
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
      required this.decoration,
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
            height: height,
            width: width,
            decoration: decoration,
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

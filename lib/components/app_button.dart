import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;
  final Widget? titleWidget;
  final TextStyle? textStyle;
  final Decoration? decoration;
  final VoidCallback onPress;
  final Color? backgroundColor;
  final double? borderRadius;
  final BorderSide? side;
  final EdgeInsets? padding;
  final bool disable_ani;
  final ShapeBorder? shapeBorder;
  final MaterialTapTargetSize? materialTapTargetSize;
  final TextAlign? textAlign;

  const AppButton({
    Key? key,
    this.textAlign,
    this.title,
    required this.onPress,
    this.height,
    this.width,
    this.textStyle,
    this.decoration,
    this.backgroundColor,
    this.borderRadius,
    this.side,
    this.padding,
    this.disable_ani = false,
    this.shapeBorder,
    this.materialTapTargetSize,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      animationDuration: const Duration(seconds: 0),
      splashColor: disable_ani ? Colors.transparent : null,
      highlightColor: disable_ani ? Colors.transparent : null,
      enableFeedback: false,
      materialTapTargetSize: materialTapTargetSize,
      padding: padding,
      height: height ?? 47,
      minWidth: width,
      color: backgroundColor,
      shape: shapeBorder ??
          RoundedRectangleBorder(
              side: side ?? const BorderSide(color: colorTransparent),
              borderRadius: BorderRadius.circular(borderRadius ?? 0)),
      child: titleWidget ??
          Text(
            title ?? '',
            textScaleFactor: 1,
            textAlign: textAlign,
            style: textStyle ?? typoNormalTextRegular,
          ),
      onPressed: () {
        Utils.hideKeyboard(context);
        onPress.call();
      },
    );
  }
}

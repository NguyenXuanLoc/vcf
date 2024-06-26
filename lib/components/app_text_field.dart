import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final bool? obscureText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? autofocus;
  final bool? readOnly;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool? enable;
  final double? height;
  final bool isShowErrorText;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatters;
  final Color? colorBorder;
  final VoidCallback? onTapOutside;
  final Color? errorTextColor;
  final TextStyle? errorTextStyle;

  const AppTextField({this.controller,
      this.errorTextColor,
      this.errorTextStyle,
      this.onTapOutside,
      this.hintText,
      this.errorText,
      this.obscureText,
      this.textInputType,
      this.textInputAction,
      this.maxLength,
      this.prefixIcon,
      this.suffixIcon,
      this.autofocus,
      this.readOnly,
      this.onEditingComplete,
      this.onChanged,
      this.onTap,
      Key? key,
      this.textStyle,
      this.hintStyle,
      this.decoration,
      this.focusNode,
      this.onSubmitted,
      this.maxLengthEnforcement,
      this.enable,
      this.height,
      this.isShowErrorText = true,
      this.maxLine,
      this.inputFormatters,
      this.colorBorder})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 5,
      children: [
        TextField(
          onTapOutside: (v) => widget.onTapOutside?.call(),
          inputFormatters: widget.inputFormatters,
          enabled: widget.enable,
          readOnly: widget.readOnly ?? false,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          focusNode: widget.focusNode,
          controller: widget.controller,
          style:
              widget.textStyle?.copyWith(height: widget.height, fontSize: 15) ??
                  typoW500.copyWith(height: widget.height, fontSize: 15),
          obscureText: widget.obscureText ?? false,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
          autofocus: widget.autofocus ?? false,
          autocorrect: false,
          maxLines: widget.maxLine ??
              (widget.textInputType == TextInputType.multiline ? 4 : 1),
          onEditingComplete: widget.onEditingComplete,
          onChanged: widget.onChanged,
          onSubmitted: (text) {
            if (widget.onSubmitted != null) widget.onSubmitted!(text);
          },
          onTap: widget.onTap,
          decoration: widget.decoration ??
              decorTextField.copyWith(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.colorBorder ?? colorGrey20, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.colorBorder ?? colorGrey20, width: 1),
                  ),
                  /*contentPadding: EdgeInsets.only(),*/
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon,
                  hintStyle: widget.hintStyle ??
                      typoW500.copyWith(
                          fontSize: 15, color: HexColor('8F8F8F'))),
        ),
        Text(
            widget.isShowErrorText
                ? (widget.errorText != null &&
                        widget.errorText.toString().isNotEmpty)
                    ? widget.errorText!
                    : ' '
                : '',
            style: widget.errorTextStyle ??
                typoNormalTextRegular.copyWith(
                    color: widget.errorTextColor ??colorSemanticRed100, fontSize: 11))
      ],
    );
  }
}

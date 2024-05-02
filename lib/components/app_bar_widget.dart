import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/dialogs.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/gen/assets.gen.dart';
import 'package:base_bloc/modules/login/login_page.dart';
import 'package:base_bloc/modules/on_boarding/on_boarding_page.dart';
import 'package:base_bloc/modules/person_infomation/person_info_page.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/hex_color.dart';
import '../generated/locale_keys.g.dart';
import 'gradient_text.dart';

PreferredSizeWidget AppbarWidget(
        {VoidCallback? goBack,
        ShapeBorder? shapeBorder,
        BuildContext? context,
        Widget? titleWidget,
        Widget? leading,
        double? leadingWidth,
        double? elevation,
        Color? backgroundColor,
        Color? shadowColor,
        Color? backColor,
        String? title,
        List<Widget>? action,
        bool landingMaxSize = false,
        bool isBoldTitle = false,
        bool enableGoBack = true,
        bool? isCenterTitle}) =>
    AppBar(
/*        toolbarHeight: context != null
            ? ((AppBarTheme.of(context).toolbarHeight ?? 56) + 10)
            : null,*/
        shape: shapeBorder,
        actions: action,
        leadingWidth: leadingWidth ?? 30,
        backgroundColor: backgroundColor ?? colorBlack,
        leading: leading ??
            (enableGoBack
                ? InkWell(
                    onTap: () => goBack?.call(),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: landingMaxSize ? 16 : 18,
                            left: contentPadding,
                            bottom: landingMaxSize ? 16 : 18),
                        child: const SizedBox()))
                : const SizedBox()),
        centerTitle: isCenterTitle ?? false,
        elevation: elevation,
        shadowColor: shadowColor,
        title: titleWidget ??
            AppText(title ?? '',
                style: isBoldTitle
                    ? typoW700.copyWith(fontSize: 25, color: colorBlack)
                    : typoW400.copyWith(fontSize: 25, color: colorBlack)));

Widget MainAppbarWidget(
        {VoidCallback? onTap,
        required BuildContext context,
        required String title,
        Widget? action}) =>
    Stack(alignment: Alignment.centerRight, children: [
      Container(
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          color: HexColor('07183A'),
          child: Row(children: [
            const SizedBox(width: 4),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(Assets.svg.icBack)),
            ),
            Expanded(
                child: AppText(title,
                    style: typoW500.copyWith(fontSize: 16, color: colorWhite),
                    textAlign: TextAlign.center)),
            Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(Assets.svg.icBack,
                    color: colorTransparent))
          ])),
      if (action != null)
        Padding(padding: EdgeInsets.only(right: contentPadding), child: action)
    ]);

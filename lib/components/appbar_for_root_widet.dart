import 'dart:async';
import 'dart:convert';

import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../data/eventbus/refresh_event.dart';
import '../data/globals.dart';
import '../gen/assets.gen.dart';
import '../generated/locale_keys.g.dart';
import '../modules/on_boarding/on_boarding_page.dart';
import '../modules/person_infomation/person_info_page.dart';
import '../router/router_utils.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';
import '../utils/app_utils.dart';
import 'dialogs.dart';
import 'gradient_text.dart';

class AppBarForRootWidget extends StatefulWidget {
  final VoidCallback? avatarOnClick;
  final bool? isHideIconCap;
  final String? titleWithBackButton;
  final VoidCallback? backOnClick;

  const AppBarForRootWidget({super.key,
    this.avatarOnClick,
    this.isHideIconCap,
    this.titleWithBackButton,
    this.backOnClick});

  @override
  State<AppBarForRootWidget> createState() => _AppBarForRootWidgetState();
}

class _AppBarForRootWidgetState extends State<AppBarForRootWidget> {
  StreamSubscription<RefreshEvent>? refreshEvent;

  @override
  void initState() {
    refreshEvent =
        Utils.eventBus.on<RefreshEvent>().listen((event) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    refreshEvent?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: 5,
            left: widget.titleWithBackButton != null ? 0 : contentPadding,
            right: contentPadding),
        child: Row(children: [
          Stack(
            alignment: Alignment.center,
            children: [
              /*userModel?.avatar != null
                  ? Image.memory(base64Decode(
                      (userModel?.avatar ?? '').replaceAll('image/', "")))
                  : */
              Image.asset(Assets.png.icApp.path,
                  width: 44,
                  color:
                  widget.isHideIconCap == true ? colorTransparent : null),
              if (widget.titleWithBackButton != null)
                Row(
                  children: [
                    InkWell(
                        child: Padding(
                            padding: EdgeInsets.all(contentPadding),
                            child: SvgPicture.asset(Assets.svg.icBack)),
                        onTap: () => widget.backOnClick?.call()),
                    GradientText(widget.titleWithBackButton ?? '',
                        style: typoW500.copyWith(fontSize: 16))
                  ],
                ),
            ],
          ),
          const Spacer(),
          InkWell(
              onTap: () {
                if (!isLogin) {
                  Dialogs.showCommonDialog(
                      LocaleKeys.you_need_login_to_use_feature.tr(),
                      context,
                          () =>
                          RouterUtils.pushTo(
                              homeContext, const OnBoardingPage()));
                  return;
                } else {
                  RouterUtils.pushTo(homeContext, const PersonInfoPage());
                }
              },
              child: userModel?.avatar != null
                  ? SizedBox(
                  width: 30,
                  height: 30,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: AppNetworkImage(
                          fit: BoxFit.cover,
                          source: userModel?.avatar ?? '',
                          errorWidget: defaultAvatarWidget())))
                  : defaultAvatarWidget())
        ]));
  }

  Widget defaultAvatarWidget() =>
      Image.asset(Assets.png.icDefaultAvatar.path, width: 30);
}

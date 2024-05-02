import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_text_button.dart';
import 'package:base_bloc/components/gradient_text.dart';
import 'package:base_bloc/components/line_widget.dart';
import 'package:base_bloc/modules/person_infomation/person_info_bloc.dart';
import 'package:base_bloc/modules/person_infomation/person_info_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../base/hex_color.dart';
import '../../components/app_bar_widget.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../data/globals.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class PersonInfoPage extends StatefulWidget {
  const PersonInfoPage({super.key});

  @override
  State<PersonInfoPage> createState() => _PersonInfoPageState();
}

class _PersonInfoPageState extends BaseState<PersonInfoPage, PersonInfoBloc> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      isFullScreen: true,
      body: Stack(
        children: [
          Image.asset(Assets.png.loginBackground.path,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space(height: MediaQuery.of(context).padding.top),
              appbar(),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  space(height: 30),
                  for (var e in userInfoWidget()) e,
                  space(height: 60),
                  for (var e in lRegisterWidget()) e,
                  for (var e in lNotifyWidget()) e,
                  for (var e in lSoftwareWidget()) e,
                  itemContentWidget(LocaleKeys.logout.tr(),
                      itemOnClick: () => bloc.logoutOnClick(context))
                ])),
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> lSoftwareWidget() => [
        titleWidget(LocaleKeys.About_software.tr()),
        itemContentWidget(LocaleKeys.Privacy_Policy.tr()),
        line(),
        itemContentWidget(LocaleKeys.Terms_of_use.tr()),
        line(),
        BlocBuilder<PersonInfoBloc, PersonInfoState>(
            bloc: bloc,
            builder: (c, state) => itemContentWidget(LocaleKeys.Version.tr(),
                rightWidget: AppText("Ver ${state.currentVer}",
                    style: typoW400.copyWith(
                        fontSize: 14, color: HexColor(("2868EE")))))),
        line(),
      ];

  List<Widget> lNotifyWidget() => [
        titleWidget(LocaleKeys.Notify.tr()),
        itemContentWidget(LocaleKeys.Notify_when_there_is_a_message.tr(),
            rightWidget: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HexColor("2868EE")),
                width: 34,
                height: 20,
                child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: colorWhite)))),
        line()
      ];

  List<Widget> lRegisterWidget() => [
        titleWidget(LocaleKeys.Register.tr()),
        itemContentWidget(LocaleKeys.Asked_Questions.tr()),
        line(),
        itemContentWidget(LocaleKeys.Registration_information.tr()),
        line(),
        itemContentWidget(LocaleKeys.Favorites_list.tr()),
        line(),
      ];

  Widget line() => LineWidget();

  Widget titleWidget(String title) => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: contentPadding),
      width: MediaQuery.of(context).size.width,
      height: 36,
      color: HexColor("222831"),
      child: AppText(title.toUpperCase(),
          style: typoW400.copyWith(
              color: colorWhite.withOpacity(0.6), fontSize: 10)));

  Widget itemContentWidget(String content,
          {Widget? rightWidget, VoidCallback? itemOnClick}) =>
      InkWell(
        onTap: () => itemOnClick?.call(),
        child: Padding(
          padding: EdgeInsets.all(contentPadding + 2),
          child: Row(
            children: [
              AppText(content,
                  style: typoW400.copyWith(fontSize: 16, color: colorWhite)),
              const Spacer(),
              rightWidget ??
                  SvgPicture.asset(Assets.svg.icBackRight,
                      color: HexColor("2342C0"), width: 6)
            ],
          ),
        ),
      );

  List<Widget> userInfoWidget() => [
        SizedBox(
            width: 85,
            height: 85,
            child: Image.asset(Assets.png.icDefaultAvatar.path)),
        space(),
        BlocBuilder<PersonInfoBloc, PersonInfoState>(
            builder: (c, state) => AppText(
                "${state.userModel?.firstName ?? ''} ${(state.userModel?.lastName ?? '')}",
                style: typoW700.copyWith(fontSize: 24, color: colorWhite)),
            bloc: bloc),
        space(height: 10),
        BlocBuilder<PersonInfoBloc, PersonInfoState>(
            builder: (c, state) => AppText(state.userModel?.email ?? '',
                style: typoW500.copyWith(fontSize: 16, color: colorWhite)),
            bloc: bloc),
      ];

  Widget space({double? height}) => SizedBox(height: height ?? 17);

  Widget appbar() => MainAppbarWidget(
      context: context,
      title: LocaleKeys.Personal_information.tr(),
      action: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
          child: GradientText(LocaleKeys.Update.tr(),
              style: typoW500.copyWith(fontSize: 14)),
        ),
        onTap: () => bloc.updateOnClick(context),
      ));

  @override
  PersonInfoBloc createCubit() => PersonInfoBloc();

  @override
  void init() {}
}

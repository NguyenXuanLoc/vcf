import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/modules/home_page/home_bloc.dart';
import 'package:base_bloc/modules/home_page/home_state.dart';
import 'package:base_bloc/modules/root/root_athlete.dart';
import 'package:base_bloc/modules/root/root_home.dart';
import 'package:base_bloc/modules/root/root_race.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/dialogs.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../root/root_news.dart';

class HomePage extends StatefulWidget {
  final bool isOpenLoginScreen;

  const HomePage({Key? key, this.isOpenLoginScreen = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  @override
  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.setContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WillPopScope(
        onWillPop: () async => bloc.onWillPop(),
        child: AppScaffold(
            extendBody: true,
            isFullScreen: true,
            isPadding: false,
            body: PageView(
                controller: bloc.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  RootHome(
                      navigatorKey: bloc
                          .navigatorKeys[BottomNavigationConstant.TAB_HOME]!),
                  RootRace(
                      navigatorKey: bloc
                          .navigatorKeys[BottomNavigationConstant.TAB_RACE]!),
                  RootAthlete(
                      navigatorKey: bloc.navigatorKeys[
                          BottomNavigationConstant.TAB_ATHLETE]!),
                  RootNews(
                      navigatorKey: bloc.navigatorKeys[
                          BottomNavigationConstant.TAB_PROFILE]!),
                ]),
            bottomNavigationBar: bottomNavigationWidget(context)),
      ),
      // notifyWidget()
    ]);
  }

  Widget bottomNavigationWidget(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15, left: 16, right: 16),
        height: 72,
        decoration: BoxDecoration(
            color: HexColor("061739"),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Row(children: [
              itemBottomBar(LocaleKeys.Login.tr(), Assets.svg.icHome,
                  BottomNavigationConstant.TAB_HOME, context,
                  size: 29),
              itemBottomBar(LocaleKeys.Login.tr(), Assets.svg.icGraph,
                  BottomNavigationConstant.TAB_RACE, context),
              itemBottomBar(LocaleKeys.Login.tr(), Assets.svg.icHat,
                  BottomNavigationConstant.TAB_ATHLETE, context,
                  size: 27),
              itemBottomBar(LocaleKeys.Login.tr(), Assets.svg.icMore,
                  BottomNavigationConstant.TAB_PROFILE, context,
                  size: 29)
            ])));
  }

  Widget itemBottomBar(
          String title, String assetSvg, int index, BuildContext context,
          {double? size}) =>
      Expanded(
          child: Center(
              child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: bloc,
                  builder: (c, state) => InkWell(
                      highlightColor: colorTransparent,
                      splashColor: colorTransparent,
                      child: Wrap(children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: bloc.currentIndex == index
                                    ? LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                            HexColor("38BAEA"),
                                            HexColor("4869F0")
                                          ])
                                    : null),
                            child: SvgPicture.asset(assetSvg,
                                fit: BoxFit.contain,
                                width: 20,
                                color: bloc.currentIndex == index
                                    ? colorWhite
                                    : HexColor('9CA3B0')))
                      ]),
                      onTap: () => bloc.jumpToPage(index, context)))));

  @override
  void dispose() {
    super.dispose();
  }

  @override
  HomeBloc createCubit() => HomeBloc();
}

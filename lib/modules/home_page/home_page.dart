import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/localization/locale_keys.dart';
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

import '../../gen/assets.gen.dart';
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
      AppScaffold(
          extendBody: true,
          backgroundColor: colorWhite,
          isFullScreen: true,
          isPadding: false,
          body: PageView(
              controller: bloc.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                RootHome(),
                RootRace(),
                RootAthlete(),
                RootNews(),
              ]),
          bottomNavigationBar: bottomNavigationWidget(context)),
      // notifyWidget()
    ]);
  }

  Widget bottomNavigationWidget(BuildContext context) {
    return Container(
        height: 65,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: BottomAppBar(
                elevation: 0,
                color: colorWhite,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      itemBottomBar(
                          LocaleKeys.Deal.tr(),
                          Assets.svg.icMap,
                          Assets.svg.icMap,
                          BottomNavigationConstant.TAB_HOME,
                          context,
                          assetSvgDarkMode: Assets.svg.icDealDarkMode,
                          iconChooseDarkMode: Assets.svg.icWhiteDealDarkMode,
                          size: 29),
                      itemBottomBar(
                          LocaleKeys.Map.tr(),
                          Assets.svg.icMap,
                          Assets.svg.icMap,
                          BottomNavigationConstant.TAB_RACE,
                          context,
                          assetSvgDarkMode: Assets.svg.icMapDarkMode,
                          iconChooseDarkMode: Assets.svg.icWhiteMapDarkMode),
                      itemBottomBar(
                          LocaleKeys.Cooperation.tr(),
                          Assets.svg.icMap,
                          Assets.svg.icMap,
                          BottomNavigationConstant.TAB_ATHLETE,
                          context,
                          assetSvgDarkMode: Assets.svg.icCouponDarkMode,
                          iconChooseDarkMode: Assets.svg.icWhiteCouponDarkMode,
                          size: 27),
                      itemBottomBar(
                          LocaleKeys.Profile.tr(),
                          Assets.svg.icMap,
                          Assets.svg.icMap,
                          BottomNavigationConstant.TAB_PROFILE,
                          context,
                          assetSvgDarkMode: Assets.svg.icPersonDarkMode,
                          iconChooseDarkMode: Assets.svg.icWhitePersonDarkMode,
                          size: 29)
                    ]))));
  }

  Widget itemBottomBar(String title, String assetSvg, String iconChoose,
          int index, BuildContext context,
          {required String assetSvgDarkMode,
          required String iconChooseDarkMode,
          double? size}) =>
      BlocBuilder<HomeBloc, HomeState>(
          bloc: bloc,
          builder: (c, state) => Expanded(
              child: InkWell(
                  highlightColor: colorTransparent,
                  splashColor: colorTransparent,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            child: SvgPicture.asset(
                                index == bloc.currentIndex
                                    ? iconChoose
                                    : assetSvg,
                                fit: BoxFit.contain,
                                width: size ?? 26),
                          ),
                          const SizedBox(height: 5),
                          AppText(title,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                              style: typoW500.copyWith(
                                  fontSize: 10,
                                  color: index == bloc.currentIndex
                                      ? colorWhite
                                      : colorWhite))
                        ]),
                  ),
                  onTap: () => bloc.jumpToPage(index, context))));

  @override
  void dispose() {
    super.dispose();
  }

  @override
  HomeBloc createCubit() => HomeBloc();
}

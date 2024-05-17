import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/components/app_not_data_widget.dart';
import 'package:base_bloc/components/app_refresh_widget.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/item_athlete_widget.dart';
import 'package:base_bloc/components/item_race_widget.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/tab_home/tab_home_bloc.dart';
import 'package:base_bloc/modules/tab_home/tab_home_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/app_bar_widget.dart';
import '../../components/appbar_for_root_widet.dart';
import '../../gen/assets.gen.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends BaseState<TabHome, TabHomeBloc>
    with AutomaticKeepAliveClientMixin {
  @override
  void init() {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isFullScreen: true,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Opacity(
                opacity: 0.03,
                child: SvgPicture.asset(Assets.svg.icBikeCircle)),
            content()
          ],
        ));
  }

  Widget content() {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: AppRefreshWidget(
          onRefresh: () => bloc.onRefresh(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: paddingBottomNav),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const AppBarForRootWidget(),
                  space(),
                  for (var e in raceWidget()) e,
                  space(height: 35),
                  for (var e in athleteWidget()) e,
                  space(height: 35),
          /*        for (var e in tournamentImageWidget()) e,
                  space()*/
                ])),
          ),
        ));
  }

  List<Widget> raceWidget() => [
        titleWidget(LocaleKeys.Tournament_information.tr(),
            allOnClick: () => bloc.allRaceOnClick()),
        space(),
        BlocBuilder<TabHomeBloc, TabHomeState>(
            bloc: bloc,
            builder: (c, state) => state.isRaceLoading
                ? AppCircleLoading(
                    height: MediaQuery.of(context).size.width / 1.85 * 0.67)
                : state.lRace.isEmpty
                    ? appNotDataWidget(
                        height: MediaQuery.of(context).size.width / 1.85 * 0.67)
                    : Padding(
                        padding: EdgeInsets.only(left: contentPadding),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              for (var e in state.lRace)
                                ItemTournamentWidget(
                                    model: e,
                                    itemOnClick: () =>
                                        bloc.itemTournamentOnClick(e, context))
                            ]))))
      ];

  List<Widget> athleteWidget() => [
        titleWidget(LocaleKeys.Top_Athletes.tr(),
            allOnClick: () => bloc.allAthleteOnClick()),
        space(),
        BlocBuilder<TabHomeBloc, TabHomeState>(
            bloc: bloc,
            builder: (c, state) => state.isAthleteLoading
                ? AppCircleLoading(
                    height: MediaQuery.of(context).size.width / 1.85 * 1.2)
                : state.lAthlete.isEmpty
                    ? appNotDataWidget(
                        height: MediaQuery.of(context).size.width / 1.85 * 1.2)
                    : Padding(
                        padding: EdgeInsets.only(left: contentPadding),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              for (var e in state.lAthlete)
                                ItemAthleteWidget(
                                    model: e,
                                    itemOnClick: () =>
                                        bloc.itemAthleteOnClick(e, context))
                            ])),
                      ))
      ];

  Widget appNotDataWidget({double? height}) => Container(
      alignment: Alignment.center,
      height: height,
      child: const AppNotDataWidget());

  Widget titleWidget(String title, {VoidCallback? allOnClick}) => Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleWidget(title: title, size: 20),
            InkWell(
                onTap: () => allOnClick?.call(),
                child: AppText(LocaleKeys.All.tr(),
                    style: typoW400.copyWith(
                        fontSize: 12, color: HexColor("2868EE"))))
          ],
        ),
      );

  Widget space({double? height}) => SizedBox(height: height ?? 20);

  @override
  bool get wantKeepAlive => true;

  @override
  createCubit() => TabHomeBloc();

  @override
  void dispose() {
    super.dispose();
  }
}

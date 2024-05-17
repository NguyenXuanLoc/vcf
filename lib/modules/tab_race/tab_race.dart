import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/bike_cirlce_background_widget.dart';
import 'package:base_bloc/components/item_race_news_widget.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/tab_race/tab_race_bloc.dart';
import 'package:base_bloc/modules/tab_race/tab_race_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/app_bar_widget.dart';
import '../../components/app_not_data_widget.dart';
import '../../components/app_refresh_widget.dart';
import '../../components/app_scalford.dart';
import '../../components/appbar_for_root_widet.dart';
import '../../components/item_city_widget.dart';
import '../../data/globals.dart';
import '../../gen/assets.gen.dart';

class TabRace extends StatefulWidget {
  const TabRace({Key? key}) : super(key: key);

  @override
  State<TabRace> createState() => _TabRaceState();
}

class _TabRaceState extends BaseState<TabRace, TabRaceBloc>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isFullScreen: true,
        body: Stack(
            alignment: Alignment.topCenter,
            children: [BikeCircleBackGroundWidget(), content()]));
  }

  Widget content() {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: contentPadding,
            right: contentPadding),
        child: AppRefreshWidget(
            onRefresh: () => bloc.onRefresh(),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                    controller: bloc.controller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: paddingBottomNav),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBarForRootWidget(isHideIconCap: true),
                          space(),
                          TitleWidget(
                              title: LocaleKeys.Tournament_information.tr()),
                          space(height: 10),
                          cityWidget(),
                          newWidget()
                        ])))));
  }

  Widget appNotDataWidget({double? height}) => Container(
      alignment: Alignment.center,
      height: height,
      child: const AppNotDataWidget());

  Widget newWidget() => BlocBuilder<TabRaceBloc, TabRaceState>(
      builder: (context, state) => state.isRaceLoading && state.lRace.isEmpty
          ? AppCircleLoading(height: MediaQuery.of(context).size.height / 1.7)
          : state.lRace.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: const AppNotDataWidget())
              : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      index == state.lRace.length
                          ? const AppCircleLoading()
                          : ItemRaceNewsWidget(
                              model: state.lRace[index],
                              itemOnClick: () => bloc.itemTournamentOnClick(
                                  state.lRace[index], context)),
                  itemCount: state.lRace.isNotEmpty &&
                          state.isRaceLoading &&
                          !state.isReadEnd
                      ? state.lRace.length + 1
                      : state.lRace.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 15),
                ),
      bloc: bloc);

  Widget cityWidget() => SizedBox(
      height: 70,
      child: BlocBuilder<TabRaceBloc, TabRaceState>(
          builder: (c, state) => state.isCityLoading
              ? const AppCircleLoading()
              : state.lCity.isEmpty
                  ? appNotDataWidget()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < state.lCity.length; i++)
                            ItemFilterWidget(
                                itemOnClick: () => bloc.cityOnClick(i),
                                content: state.lCity[i].name ?? '',
                                isSelect: state.lCity[i].isSelect)
                        ],
                      ),
                    ),
          bloc: bloc));

  Widget space({double? height}) => SizedBox(height: height ?? 20);

  @override
  bool get wantKeepAlive => true;

  @override
  createCubit() => TabRaceBloc();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void init() {}
}

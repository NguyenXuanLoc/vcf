import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/data/model/race_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/race_detail/race_detail_bloc.dart';
import 'package:base_bloc/modules/race_detail/race_detail_state.dart';
import 'package:base_bloc/modules/round_detail/round_detail_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../components/app_bar_widget.dart';
import '../../components/app_circle_loading.dart';
import '../../components/app_not_data_widget.dart';
import '../../components/app_refresh_widget.dart';
import '../../components/app_scalford.dart';
import '../../components/appbar_for_root_widet.dart';
import '../../components/bike_cirlce_background_widget.dart';
import '../../components/item_city_widget.dart';
import '../../data/globals.dart';

class RaceDetailPage extends StatefulWidget {
  final RaceModel model;
  final int root;

  const RaceDetailPage({super.key, required this.model, required this.root});

  @override
  State<RaceDetailPage> createState() => _RaceDetailPageState();
}

class _RaceDetailPageState extends BaseState<RaceDetailPage, RaceDetailCubit> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isFullScreen: true,
        body: Stack(
            alignment: Alignment.topCenter,
            children: [const BikeCircleBackGroundWidget(), content()]));
  }

  Widget content() {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: AppRefreshWidget(
            onRefresh: () => bloc.getRaceDetail(),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarForRootWidget(
                        backOnClick: () => Navigator.pop(context),
                        isHideIconCap: true,
                        titleWithBackButton:
                            LocaleKeys.Tournament_information.tr(),
                      ),
                      paddingWidget(
                          TitleWidget(title: widget.model.name ?? '')),
                      roundWidget(),
                      roundDetailWidget()
                    ]))));
  }

  Widget roundDetailWidget() {
    return Expanded(
        child: BlocBuilder<RaceDetailCubit, RaceDetailState>(
            builder: (c, state) => state.isLoading
                ? const AppCircleLoading()
                : state.raceDetailModel == null
                    ? appNotDataWidget()
                    : PageView(controller: bloc.pageController, children: [
                        for (var element in state.raceDetailModel!.rounds!)
                          RoundDetailPage(model: element)
                      ]),
            bloc: bloc));
  }

  Widget paddingWidget(Widget child, {bool isPaddingRight = true}) => Padding(
      padding: EdgeInsets.only(
          left: contentPadding, right: isPaddingRight ? contentPadding : 0),
      child: child);

  Widget roundWidget() => BlocBuilder<RaceDetailCubit, RaceDetailState>(
        bloc: bloc,
        builder: (c, state) => SizedBox(
            height: 70,
            child: state.isLoading || state.raceDetailModel == null
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(left: contentPadding),
                    child: SingleChildScrollView(
                        controller: bloc.scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          for (int i = 0;
                              i < state.raceDetailModel!.rounds!.length;
                              i++)
                            AutoScrollTag(
                                key: ValueKey(i),
                                controller: bloc.scrollController,
                                index: i,
                                child: ItemFilterWidget(
                                    itemOnClick: () => bloc.roundOnClick(i),
                                    content: (state.raceDetailModel?.rounds?[i]
                                                    .name ??
                                                '')
                                            .isNotEmpty
                                        ? "${state.raceDetailModel?.rounds?[i].name}"
                                        : "${LocaleKeys.Round.tr()} ${i + 1}",
                                    isSelect: state
                                        .raceDetailModel!.rounds![i].isSelect))
                        ])))),
      );

  Widget appNotDataWidget({double? height}) => Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 70),
      height: height,
      child: const AppNotDataWidget(isStack: true));

  Widget space({double? height}) => SizedBox(height: height ?? 30);

  @override
  createCubit() => RaceDetailCubit(widget.model);

  @override
  void init() {
    // TODO: implement init
  }
}

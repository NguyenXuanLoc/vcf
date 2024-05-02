import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/data/model/tournament_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/round_detail/round_detail_page.dart';
import 'package:base_bloc/modules/tournament_detail/tournament_detail_bloc.dart';
import 'package:base_bloc/modules/tournament_detail/tournament_detail_state.dart';
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

class TournamentDetailPage extends StatefulWidget {
  final TournamentModel model;
  final int root;

  const TournamentDetailPage(
      {super.key, required this.model, required this.root});

  @override
  State<TournamentDetailPage> createState() => _TournamentDetailPageState();
}

class _TournamentDetailPageState
    extends BaseState<TournamentDetailPage, TournamentDetailCubit> {
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
            onRefresh: () {},
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
                      paddingWidget(TitleWidget(title: widget.model.name)),
                      roundWidget(),
                      roundDetailWidget()
                    ]))));
  }

  Widget roundDetailWidget() {
    return Expanded(
      child: BlocBuilder<TournamentDetailCubit, TournamentDetailState>(
          builder: (c, state) => state.isRoundLoading
              ? const AppCircleLoading()
              : PageView(controller: bloc.pageController, children: [
                  for (int i = 0; i < state.lRound.length; i++)
                    RoundDetailPage(model: state.lRound[i])
                ]),
          bloc: bloc),
    );
  }

  Widget paddingWidget(Widget child, {bool isPaddingRight = true}) => Padding(
      padding: EdgeInsets.only(
          left: contentPadding, right: isPaddingRight ? contentPadding : 0),
      child: child);

  Widget roundWidget() => SizedBox(
      height: 70,
      child: BlocBuilder<TournamentDetailCubit, TournamentDetailState>(
          builder: (c, state) => state.isRoundLoading
              ? const AppCircleLoading()
              : state.lRound.isEmpty
                  ? appNotDataWidget()
                  : Padding(
                      padding: EdgeInsets.only(left: contentPadding),
                      child: SingleChildScrollView(
                        controller: bloc.scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < state.lRound.length; i++)
                              AutoScrollTag(
                                  key: ValueKey(i),
                                  controller: bloc.scrollController,
                                  index: i,
                                  child: ItemFilterWidget(
                                      itemOnClick: () => bloc.roundOnClick(i),
                                      content: state.lRound[i].name ?? '',
                                      isSelect: state.lRound[i].isSelect))
                          ],
                        ),
                      ),
                    ),
          bloc: bloc));

  Widget appNotDataWidget({double? height}) => Container(
      alignment: Alignment.center,
      height: height,
      child: const AppNotDataWidget());

  Widget space({double? height}) => SizedBox(height: height ?? 30);

  @override
  createCubit() => TournamentDetailCubit(widget.model);

  @override
  void init() {
    // TODO: implement init
  }
}

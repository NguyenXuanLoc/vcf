import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/components/app_not_data_widget.dart';
import 'package:base_bloc/components/app_refresh_widget.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_button.dart';
import 'package:base_bloc/components/item_other_athlete_widget.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/athlete_detail/athlete_detail_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/item_top_athlete_widget.dart';
import '../../gen/assets.gen.dart';
import '../../utils/app_utils.dart';
import 'athlete_detail_bloc.dart';

class AthleteDetailPage extends StatefulWidget {
  final AthleteModel model;
  final int root;

  const AthleteDetailPage({super.key, required this.model, required this.root});

  @override
  State<AthleteDetailPage> createState() => _AthleteDetailPageState();
}

class _AthleteDetailPageState
    extends BaseState<AthleteDetailPage, AthleteDetailBloc> {
  @override
  Widget build(BuildContext context) {
    return AppRefreshWidget(
      onRefresh: () => bloc.onRefresh(),
      child: AppScaffold(
          body: BlocBuilder<AthleteDetailBloc, AthleteDetailState>(
              builder: (c, state) => Stack(
                    children: [
                      state.isAthLoading
                          ? const AppCircleLoading()
                          : state.athleteModel == null
                              ? const AppNotDataWidget(isStack: true)
                              : contentWidget(state),
                      if (state.athleteModel == null) backWidget()
                    ],
                  ),
              bloc: bloc),
          isPadding: false,
          isFullScreen: true),
    );
  }

  Widget backWidget() => Padding(
      padding: EdgeInsets.only(
          left: contentPadding + 7,
          top: MediaQuery.of(context).padding.top + contentPadding + 7),
      child: GradientButton(
          onTap: () => Navigator.pop(context),
          widget: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(Assets.svg.icBack, color: colorWhite)),
          height: 36,
          width: 36));

  Widget posterWidget(AthleteDetailState state) => Stack(children: [
        AspectRatio(
            aspectRatio: 1 / 0.95,
            child: AppNetworkImage(
                source: ConstantKey.BASE_IMAGE_URL +
                    (state.athleteModel?.photo ?? ''))),
        backWidget(),
        Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.topCenter,
                    height: 24,
                    decoration: BoxDecoration(
                        color: HexColor("11203D"),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(24),
                            topLeft: Radius.circular(24))),
                    child: Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: colorWhite)))))
      ]);

  Widget contentWidget(AthleteDetailState state) => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: paddingBottomNav),
            physics: const AlwaysScrollableScrollPhysics(),
            controller: bloc.controller,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              posterWidget(state),
              for (var e in infoUserWidget(state))
                Padding(
                    padding: EdgeInsets.only(
                        left: contentPadding + 7, right: contentPadding + 7),
                    child: e)
            ])),
      );

  List<Widget> infoUserWidget(AthleteDetailState state) => [
        space(height: 7),
        AppText(
            "${state.athleteModel?.firstName ?? ""} ${state.athleteModel?.middleName ?? ""} ${state.athleteModel?.lastName ?? ""}",
            style: typoW700.copyWith(fontSize: 24, color: colorWhite)),
        space(),
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 7, right: 7, top: 2, bottom: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: HexColor("DB241D")),
              child: AppText(
                  "${LocaleKeys.Top} ${state.athleteModel?.score ?? 0}",
                  style: typoW400.copyWith(fontSize: 12, color: colorWhite)),
            ),
            Expanded(
                child: AppText(
                    "   ${Utils.getAgeByBirthDay(state.athleteModel?.birthDate)} ${LocaleKeys.Age.tr().toLowerCase()}${(state.athleteModel?.city ?? '').isNotEmpty ? "," : ""} ${state.athleteModel?.city ?? ''}",
                    maxLine: 1,
                    style: typoW500.copyWith(
                        fontSize: 12, color: colorWhite.withOpacity(0.6))))
          ],
        ),
        space(),
        AppText(state.athleteModel?.description ?? '',
            style: typoW400.copyWith(
                fontSize: 12, color: colorWhite.withOpacity(0.5))),
        space(),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: colorWhite.withOpacity(0.12)),
        for (var e in anotherAthleteWidget(state)) e
      ];

  List<Widget> anotherAthleteWidget(AthleteDetailState state) {
    return [
      space(),
      AppText(LocaleKeys.Another_Athlete.tr(),
          style: typoW700.copyWith(fontSize: 16, color: colorWhite)),
      space(),
      relatedWidget()
    ];
  }

  Widget relatedWidget() => BlocBuilder<AthleteDetailBloc, AthleteDetailState>(
      builder: (context, state) => state.isRelatedLoading &&
              state.lRelated.isEmpty
          ? const AppCircleLoading(height: 100)
          : state.lRelated.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: const AppNotDataWidget())
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      index == state.lRelated.length
                          ? const AppCircleLoading()
                          : ItemOtherAthleteWidget(
                              model: state.lRelated[index],
                              itemOnClick: () => bloc.itemOnClick(
                                  state.lRelated[index], widget.root, context)),
                  itemCount: state.lRelated.isNotEmpty &&
                          state.isRelatedLoading &&
                          !state.isRelatedReadEnd
                      ? state.lRelated.length + 1
                      : state.lRelated.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 20)),
      bloc: bloc);

  Widget space({double? height}) => SizedBox(height: height ?? 15);

  @override
  AthleteDetailBloc createCubit() => AthleteDetailBloc(widget.model);

  @override
  void init() {
    // TODO: implement init
  }
}

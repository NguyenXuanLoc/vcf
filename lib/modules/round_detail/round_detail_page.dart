import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/gradient_text.dart';
import 'package:base_bloc/data/model/race_detail_model.dart';
import 'package:base_bloc/data/model/round_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/round_detail/round_detail_bloc.dart';
import 'package:base_bloc/modules/round_detail/round_detail_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/app_not_data_widget.dart';
import '../../components/gradient_button.dart';
import '../../data/globals.dart';
import '../../gen/assets.gen.dart';
import '../../utils/app_utils.dart';

class RoundDetailPage extends StatefulWidget {
  final RaceDetailModel model;

  const RoundDetailPage({super.key, required this.model});

  @override
  State<RoundDetailPage> createState() => _RoundDetailPageState();
}

class _RoundDetailPageState extends BaseState<RoundDetailPage, RoundDetailBloc>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return contentWidget();
  }

  Widget contentWidget() => BlocBuilder<RoundDetailBloc, RoundDetailState>(
      builder: (c, state) => state.isLoading
          ? const AppCircleLoading()
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: paddingBottomNav),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    space(height: 20),
                    AspectRatio(
                        aspectRatio: 285 / 114,
                        child: Center(
                            child:
                                AppNetworkImage(source: state.model?.photo))),
                    space(),
                    for (var e in lCityInfoWidget(state)) e,
                    space(),
                    lRoundInfoWidget(state),
                    space(),
                    // buyTicketButton
                  ])),
      bloc: bloc);

  @override
  RoundDetailBloc createCubit() => RoundDetailBloc(widget.model);

  @override
  void init() {}

  Widget get buyTicketButton => Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: GradientButton(
            width: MediaQuery.of(context).size.width,
            onTap: () {},
            isCenter: true,
            widget: AppText(LocaleKeys.Buy_ticket.tr(),
                style: typoW700.copyWith(fontSize: 16, color: colorWhite))),
      );

  Widget lRoundInfoWidget(RoundDetailState state) => state.isLoading
      ? const AppCircleLoading()
      : CustomScrollView(shrinkWrap: true, primary: false, slivers: <Widget>[
          SliverPadding(
              padding:
                  EdgeInsets.only(left: contentPadding, right: contentPadding),
              sliver: SliverGrid.count(
                  crossAxisSpacing: 10,
                  childAspectRatio: 164 / 42,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    itemContentWidget(LocaleKeys.Starting_point.tr(),
                        state.model?.startPoint ?? ''),
                    itemContentWidget(LocaleKeys.Ending_point.tr(),
                        state.model?.endPoint ?? ''),
                    itemContentWidget(LocaleKeys.Race_Length.tr(),
                        "${state.model?.distance ?? 0}"),
                    itemContentWidget(
                        LocaleKeys.Map.tr(), state.model?.terrain ?? ''),
                    /* itemContentWidget(
                         LocaleKeys.Free_water_distribution_point.tr(),
                        'waterFree'),*/
                    itemContentWidget(
                        LocaleKeys.Number_of_participating_athletes.tr(),
                        "${state.model?.numberOfAthletic ?? 0} ${LocaleKeys.Athletes.tr()}"),
                    itemContentWidget(LocaleKeys.Participation_costs.tr(),
                        Utils.formatMoney(state.model?.price)),
                    itemContentWidget(
                        LocaleKeys.Donors.tr(), state.model?.sponsor ?? '')
                  ]))
        ]);

  Widget itemContentWidget(String title, String? content) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: HexColor("07183A")),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          AppText(title,
              style: typoW600.copyWith(fontSize: 10, color: colorWhite)),
          AppText(
            content ?? '',
            style: typoW300.copyWith(fontSize: 10, color: colorWhite),
          )
        ]),
      );

  List<Widget> lCityInfoWidget(RoundDetailState state) => [
        Center(
            child: AppText(state.model?.description ?? '',
                style: typoW700.copyWith(fontSize: 16, color: colorWhite))),
        space(height: 2),
        Center(
            child: GradientText(
                Utils.formatDateToddMMYYYY(state.model?.raceDate),
                style: typoW700.copyWith(fontSize: 12)))
      ];

  Widget paddingWidget(Widget child, {bool isPaddingRight = true}) => Padding(
      padding: EdgeInsets.only(
          left: contentPadding, right: isPaddingRight ? contentPadding : 0),
      child: child);

  Widget space({double? height}) => SizedBox(height: height ?? 30);

  Widget appNotDataWidget({double? height}) => Container(
      alignment: Alignment.center,
      height: height,
      child: const AppNotDataWidget());

  @override
  bool get wantKeepAlive => true;
}

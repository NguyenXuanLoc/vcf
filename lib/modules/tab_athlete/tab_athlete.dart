import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/bike_cirlce_background_widget.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/modules/tab_athlete/tab_athlete_bloc.dart';
import 'package:base_bloc/modules/tab_athlete/tab_athlete_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/app_circle_loading.dart';
import '../../components/app_not_data_widget.dart';
import '../../components/app_refresh_widget.dart';
import '../../components/app_scalford.dart';
import '../../components/appbar_for_root_widet.dart';
import '../../components/item_top_athlete_widget.dart';
import '../../data/globals.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class TabAthlete extends StatefulWidget {
  const TabAthlete({Key? key}) : super(key: key);

  @override
  State<TabAthlete> createState() => _TabAthleteState();
}

class _TabAthleteState extends BaseState<TabAthlete, TabAthleteBloc>
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
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                          Padding(
                              padding: EdgeInsets.only(
                                  left: contentPadding, right: contentPadding),
                              child: TitleWidget(
                                  title: LocaleKeys.Top_Athletes.tr())),
                          space(height: 25),
                          filterWidget(),
                          space(height: 25),
                          athWidget()
                        ])))));
  }

  Widget athWidget() => BlocBuilder<TabAthleteBloc, TabAthleteState>(
      builder: (context, state) => state.isLoading && state.lAth.isEmpty
          ? AppCircleLoading(height: MediaQuery.of(context).size.height / 1.7)
          : state.lAth.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: const AppNotDataWidget())
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      index == state.lAth.length
                          ? const AppCircleLoading()
                          : ItemTopAthleteWidget(
                              model: state.lAth[index],
                              itemOnClick: () =>
                                  bloc.itemOnClick(state.lAth[index], context),
                              index: index),
                  itemCount: state.lAth.isNotEmpty &&
                          state.isLoading &&
                          !state.isReadEnd
                      ? state.lAth.length + 1
                      : state.lAth.length),
      bloc: bloc);

  Widget space({double? height}) => SizedBox(height: height ?? 20);

  Widget filterWidget() => Center(
          child: Padding(
        padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: BlocBuilder<TabAthleteBloc, TabAthleteState>(
          bloc: bloc,
          builder: (c, state) => state.mMale.isEmpty
              ? const SizedBox()
              : DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                      isExpanded: true,
                      items: state.mMale.keys
                          .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(item,
                                      style: typoW600.copyWith(
                                          color: colorWhite, fontSize: 14),
                                      overflow: TextOverflow.ellipsis))))
                          .toList(),
                      value: state.male,
                      onChanged: (String? value) =>
                          bloc.filterOnClick(value ?? ''),
                      buttonStyleData: ButtonStyleData(
                        height: 38,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: HexColor("0041EA")),
                            color: Colors.transparent),
                      ),
                      iconStyleData: IconStyleData(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: colorWhite.withOpacity(0.6)),
                          iconSize: 14),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          elevation: 0,
                          width: MediaQuery.of(context).size.width -
                              contentPadding * 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: colorPrimaryBrand100)))),
        ),
      ));

  @override
  bool get wantKeepAlive => true;

  @override
  createCubit() => TabAthleteBloc();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void init() {}
}

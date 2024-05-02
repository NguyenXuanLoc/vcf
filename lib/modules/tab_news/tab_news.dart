import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/bike_cirlce_background_widget.dart';
import 'package:base_bloc/components/item_news_widget.dart';
import 'package:base_bloc/modules/tab_news/tab_news_bloc.dart';
import 'package:base_bloc/modules/tab_news/tab_news_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/app_bar_widget.dart';
import '../../components/app_circle_loading.dart';
import '../../components/app_not_data_widget.dart';
import '../../components/app_refresh_widget.dart';
import '../../components/app_scalford.dart';
import '../../components/appbar_for_root_widet.dart';
import '../../data/globals.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

class TabNews extends StatefulWidget {
  const TabNews({Key? key}) : super(key: key);

  @override
  State<TabNews> createState() => _TabNewsState();
}

class _TabNewsState extends BaseState<TabNews, TabNewsBloc>
    with AutomaticKeepAliveClientMixin {
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
                            child: AppText(LocaleKeys.News.tr(),
                                style: typoW700.copyWith(
                                    fontSize: 24, color: colorWhite)),
                          ),
                          space(height: 25),
                          newsWidget()
                        ])))));
  }

  Widget newsWidget() => BlocBuilder<TabNewsBloc, TabNewsState>(
      builder: (context, state) => state.isLoading && state.lNews.isEmpty
          ? AppCircleLoading(height: MediaQuery.of(context).size.height / 1.7)
          : state.lNews.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: const AppNotDataWidget())
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => index ==
                          state.lNews.length
                      ? const AppCircleLoading()
                      : ItemNewsWidget(
                          model: state.lNews[index],
                          itemOnClick: () =>
                              bloc.itemOnClick(state.lNews[index], context)),
                  itemCount: state.lNews.isNotEmpty &&
                          state.isLoading &&
                          !state.isReadEnd
                      ? state.lNews.length + 1
                      : state.lNews.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 15)),
      bloc: bloc);

  Widget space({double? height}) => SizedBox(height: height ?? 20);

  @override
  bool get wantKeepAlive => true;

  @override
  createCubit() => TabNewsBloc();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void init() {}
}

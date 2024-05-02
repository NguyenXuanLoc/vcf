import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_circle_loading.dart';
import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/components/app_not_data_widget.dart';
import 'package:base_bloc/components/app_refresh_widget.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/bike_cirlce_background_widget.dart';
import 'package:base_bloc/components/gradient_text.dart';
import 'package:base_bloc/components/item_news_widget.dart';
import 'package:base_bloc/components/line_widget.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/data/model/news_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/appbar_for_root_widet.dart';
import '../../gen/assets.gen.dart';
import '../../utils/app_utils.dart';
import 'news_detail_bloc.dart';
import 'news_detail_state.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsModel model;
  final int root;

  const NewsDetailPage({super.key, required this.model, required this.root});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends BaseState<NewsDetailPage, NewsDetailBloc> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        isPadding: false,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [const BikeCircleBackGroundWidget(), contentWidget()],
        ));
  }

  Widget contentWidget() => SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        appbar(),
        Expanded(
            child: AppRefreshWidget(
                onRefresh: () => bloc.onRefresh(),
                child: BlocBuilder<NewsDetailBloc, NewsDetailState>(
                    builder: (c, state) => state.isNewsLoading
                        ? const AppCircleLoading()
                        : state.newsModel == null
                            ? const AppNotDataWidget(isStack: true)
                            : SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: bloc.controller,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      space(height: 15),
                                      paddingWidget(TitleWidget(
                                          title: state.newsModel?.name ?? '',
                                          size: 20)),
                                      space(),
                                      posterWidget(state),
                                      space(),
                                      lRoundInfoWidget(),
                                      space(),
                                      paddingWidget(AppText(
                                        state.newsModel?.description ?? '',
                                        style: typoW400.copyWith(
                                            fontSize: 12,
                                            color: colorWhite.withOpacity(0.7)),
                                      )),
                                      space(),
                                      paddingWidget(LineWidget()),
                                      space(),
                                      for (var e in anotherNewsWidget(state)) e
                                    ])),
                    bloc: bloc)))
      ]));

  Widget lRoundInfoWidget() =>
      CustomScrollView(shrinkWrap: true, primary: false, slivers: <Widget>[
        SliverPadding(
            padding:
                EdgeInsets.only(left: contentPadding, right: contentPadding),
            sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                childAspectRatio: 164 / 42,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  itemContentWidget(LocaleKeys.Starting_point.tr(), 'Hà nội'),
                  itemContentWidget(
                      LocaleKeys.Number_of_participating_athletes.tr(),
                      "100 ${LocaleKeys.Athletes.tr()}"),
                  itemContentWidget(LocaleKeys.Participation_costs.tr(),
                      Utils.formatMoney(1000000)),
                  itemContentWidget(LocaleKeys.Donors.tr(), "AWS")
                ]))
      ]);

  Widget itemContentWidget(String title, String? content) => Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: HexColor("07183A")),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        AppText(title,
            style: typoW600.copyWith(fontSize: 10, color: colorWhite)),
        AppText(content ?? '',
            style: typoW300.copyWith(fontSize: 10, color: colorWhite))
      ]));

  Widget paddingWidget(Widget child) => Padding(
      padding: EdgeInsets.only(left: contentPadding, right: contentPadding),
      child: child);

  Widget posterWidget(NewsDetailState state) => AspectRatio(
      aspectRatio: 375 / 170,
      child: AppNetworkImage(source: state.newsModel?.poster));

  Widget appbar() => AppBarForRootWidget(
      backOnClick: () => Navigator.pop(context),
      isHideIconCap: true,
      titleWithBackButton: LocaleKeys.News.tr(),
      avatarOnClick: () {});

  Widget line() => LineWidget();

  List<Widget> anotherNewsWidget(NewsDetailState state) {
    return [
      paddingWidget(
        AppText(LocaleKeys.Another_news.tr(),
            style: typoW700.copyWith(fontSize: 16, color: colorWhite)),
      ),
      space(height: 15),
      paddingWidget(relatedWidget())
    ];
  }

  Widget relatedWidget() => BlocBuilder<NewsDetailBloc, NewsDetailState>(
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
                  itemBuilder: (BuildContext context, int index) => index ==
                          state.lRelated.length
                      ? const AppCircleLoading()
                      : ItemNewsWidget(
                          itemOnClick: () =>
                              bloc.itemOnClick(state.lRelated[index], context),
                          model: state.lRelated[index]),
                  itemCount: state.lRelated.isNotEmpty &&
                          state.isRelatedLoading &&
                          !state.isRelatedReadEnd
                      ? state.lRelated.length + 1
                      : state.lRelated.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 20)),
      bloc: bloc);

  Widget space({double? height}) => SizedBox(height: height ?? 20);

  @override
  NewsDetailBloc createCubit() => NewsDetailBloc(widget.model);

  @override
  void init() {}
}

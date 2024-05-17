import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/data/model/news_detail_model.dart';
import 'package:base_bloc/data/model/news_model.dart';
import 'package:base_bloc/modules/new_detail/news_detail_state.dart';
import 'package:flutter/cupertino.dart';

import '../../config/constant.dart';
import '../../router/router.dart';
import '../../router/router_utils.dart';

class NewsDetailBloc extends BaseCubit<NewsDetailState> {
  var controller = ScrollController();
  final NewsModel model;

  NewsDetailBloc(this.model) : super(NewsDetailState()) {
    controller.addListener(() {
      if (!state.isRelatedLoading &&
          !state.isRelatedReadEnd &&
          state.lRelated.isNotEmpty) {
        getRelatedAthlete(isPaging: true);
      }
    });
    state.newsModel = model;
    getNewsDetail();
  }

  void onRefresh() {
    emit(NewsDetailState(newsModel: state.newsModel));
    getNewsDetail();
  }

  void itemOnClick(NewsModel model, BuildContext context) {
    RouterUtils.pushNews(
        context: context,
        route: NewsRouter.newsDetail,
        argument: [model, BottomNavigationConstant.TAB_PROFILE]);
  }

  void getNewsDetail() async {
    emit(state.copyOf(isNewsLoading: true));
    try {
      var response =
          await repository.getNewsDetailById(state.newsModel?.slug ?? '');
      if (response.error == null) {
        var newsDetailModel = NewsDetailModel.fromJson(response.data);
        emit(state.copyOf(
            newsDetailModel: newsDetailModel, isNewsLoading: false));
        getRelatedAthlete();
      }
    } catch (ex) {
      emit(state.copyOf(isNewsLoading: false));
    }
  }

  void getRelatedAthlete({bool isPaging = false}) async {
    if (state.isRelatedLoading) return;
    emit(state.copyOf(isRelatedLoading: true));
    try {
      var response = await repository.getPost(nextPage: state.nextPage);
      if (response.error == null) {
        var lNews = newsModelFromJson(response.data)
            .where((element) => element.id != state.newsModel?.id)
            .toList();
        emit(state.copyOf(
            nextPage: state.nextPage + 1,
            isRelatedLoading: false,
            lRelated: isPaging ? (state.lRelated..addAll(lNews)) : lNews,
            isRelatedReadEnd: lNews.isEmpty));
      } else {
        emit(state.copyOf(isRelatedLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isRelatedLoading: false));
    }
  }
}

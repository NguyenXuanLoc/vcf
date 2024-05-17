import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/ext/scroll_controller_ext.dart';
import 'package:base_bloc/modules/tab_news/tab_news_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:flutter/cupertino.dart';

import '../../config/constant.dart';
import '../../data/model/news_model.dart';
import '../../router/router_utils.dart';

class TabNewsBloc extends BaseCubit<TabNewsState> {
  var controller = ScrollController();

  TabNewsBloc() : super(const TabNewsState()) {
    getNews();
    controller.paging(() {
      if (!state.isLoading && !state.isReadEnd) {
        getNews(isPaging: true);
      }
    });
  }

  void itemOnClick(NewsModel model, BuildContext context) {
    RouterUtils.pushNews(
        context: context,
        route: NewsRouter.newsDetail,
        argument: [model, BottomNavigationConstant.TAB_PROFILE]);
  }

  void onRefresh() {
    emit(const TabNewsState());
    getNews();
  }

  void getNews({bool isPaging = false}) async {
    if (state.isLoading) return;
    emit(state.copyOf(isLoading: true));
    try {
      var response = await repository.getPost(nextPage: state.nextPage);
      if (response.error == null) {
        var lRace = newsModelFromJson(response.data);
        emit(state.copyOf(
            nextPage: state.nextPage + 1,
            isLoading: false,
            lNews: isPaging ? (state.lNews..addAll(lRace)) : lRace,
            isReadEnd: lRace.isEmpty));
      } else {
        emit(state.copyOf(isLoading: false));
      }
    } catch (ex) {
      emit(state.copyOf(isLoading: false));
    }
  }
}

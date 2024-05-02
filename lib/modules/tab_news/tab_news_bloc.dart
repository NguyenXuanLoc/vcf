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

  void getNews({bool isPaging = false}) {
    if (state.isLoading || state.isReadEnd) return;
    emit(state.copyOf(isLoading: true));
    Timer(
        const Duration(seconds: 1),
        () => emit(state.copyOf(
            isLoading: false,
            isReadEnd: state.lNews.length > 20,
            lNews: !isPaging
                ? lNews().toList(growable: true)
                : (state.lNews..addAll(lNews())))));
  }

  List<NewsModel> lNews() => [
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Giải địa hình Bến Tre mở rộng',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Giải địa hình Bến Tre mở nhỏ',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Giải đá gà Bến Tre mở rộng',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        NewsModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS')
      ];
}

import 'dart:async';

import 'package:base_bloc/data/model/news_model.dart';
import 'package:base_bloc/modules/new_detail/news_detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/constant.dart';
import '../../router/router.dart';
import '../../router/router_utils.dart';

class NewsDetailBloc extends Cubit<NewsDetailState> {
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
    getNews(model);
  }

  void onRefresh() {
    emit(const NewsDetailState());
    getNews(model);
  }

  void itemOnClick(NewsModel model, BuildContext context) {
    RouterUtils.pushNews(
        context: context,
        route: NewsRouter.newsDetail,
        argument: [model, BottomNavigationConstant.TAB_PROFILE]);
  }

  void getNews(NewsModel model) {
    emit(state.copyOf(isNewsLoading: true));
    Timer(const Duration(seconds: 1), () {
      emit(state.copyOf(newsModel: model, isNewsLoading: false));
      getRelatedAthlete();
    });
  }

  void getRelatedAthlete({bool isPaging = false}) {
    if (state.isRelatedLoading || state.isRelatedReadEnd) return;
    emit(state.copyOf(isRelatedLoading: true));
    Timer(
        const Duration(seconds: 1),
        () => emit(state.copyOf(
            isRelatedLoading: false,
            isRelatedReadEnd: state.lRelated.length > 20,
            lRelated: !isPaging
                ? lNews().toList(growable: true)
                : (state.lRelated..addAll(lNews())))));
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

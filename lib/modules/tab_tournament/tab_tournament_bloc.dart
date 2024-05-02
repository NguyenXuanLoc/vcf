import 'dart:async';

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/data/model/city_model.dart';
import 'package:base_bloc/ext/scroll_controller_ext.dart';
import 'package:base_bloc/modules/tab_tournament/tab_tournament_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';

import '../../config/constant.dart';
import '../../data/model/tournament_model.dart';

class TabTournamentBloc extends BaseCubit<TabTournamentState> {
  var controller = ScrollController();

  TabTournamentBloc()
      : super(TabTournamentState(
            lNews: List.empty(growable: true),
            lCity: List.empty(growable: true))) {
    getCity();
    getNews();
    controller.paging(() {
      if (!state.isNewsLoading && !state.isReadEnd) {
        getNews(isPaging: true);
      }
    });
  }

  void onRefresh() {
    emit(const TabTournamentState());
    getCity();
    getNews();
  }

  void cityOnClick(int index) {
    state.lCity[index].isSelect = !state.lCity[index].isSelect;
    emit(state.copyOf(
        isReadEnd: false,
        lNews: [],
        isRefreshUI: !state.isRefreshUI,
        isNewsLoading: false));
    getNews();
  }

  void getCity() {
    Timer(const Duration(seconds: 1),
        () => emit(state.copyOf(isCityLoading: false, lCity: lCity())));
  }

  void itemTournamentOnClick(TournamentModel model, BuildContext context) {
    RouterUtils.pushRace(
        context: context,
        route: RaceRouter.tournamentDetail,
        argument: [model, BottomNavigationConstant.TAB_RACE]);
  }

  void getNews({bool isPaging = false}) {
    if (state.isNewsLoading || state.isReadEnd) return;
    emit(state.copyOf(isNewsLoading: true));
    Timer(
        const Duration(seconds: 1),
        () => emit(state.copyOf(
            isNewsLoading: false,
            isReadEnd: state.lNews.length > 20,
            lNews: !isPaging
                ? lNews().toList(growable: true)
                : (state.lNews..addAll(lNews())))));
  }

  List<TournamentModel> lNews() => [
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS'),
        TournamentModel(
            poster:
                "https://cdn.24h.com.vn/upload/2-2020/images/2020-04-19/1587272574-850-tung-pang2-1584268658-width650height812.jpg",
            name: 'Biwase Cup 2024',
            address: 'Hồ Hoàn Kiếm',
            dateTime: DateTime.now(),
            price: 1000000,
            donors: 'AWS')
      ];

  List<CityModel> lCity() => [
        CityModel(name: "Ha noi"),
        CityModel(name: "Hai Phong"),
        CityModel(name: "Nha Trang"),
        CityModel(name: "Khánh Hòa"),
        CityModel(name: "Nam Định"),
        CityModel(name: "Sài Gòn")
      ];
}

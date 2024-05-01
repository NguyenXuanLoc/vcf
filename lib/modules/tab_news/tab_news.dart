import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/tab_news/tab_news_bloc.dart';
import 'package:base_bloc/modules/tab_race/tab_race_bloc.dart';
import 'package:flutter/material.dart';

class TabNews extends StatefulWidget {
  const TabNews({Key? key}) : super(key: key);

  @override
  State<TabNews> createState() => _TabNewsState();
}

class _TabNewsState extends BaseState<TabNews, TabNewsBloc>
    with AutomaticKeepAliveClientMixin {
  @override
  void init() {}

  @override
  Widget build(BuildContext context) {
    return AppText(" TAB NEWs");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  createCubit() => TabNewsBloc();

  @override
  void dispose() {
    super.dispose();
  }
}

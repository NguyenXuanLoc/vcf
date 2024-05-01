import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/tab_home/tab_home_bloc.dart';
import 'package:flutter/material.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends BaseState<TabHome, TabHomeBloc>
    with AutomaticKeepAliveClientMixin {
  @override
  void init() {}

  @override
  Widget build(BuildContext context) {
    return AppText(" TAB HOME");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  createCubit() => TabHomeBloc();

  @override
  void dispose() {
    super.dispose();
  }
}

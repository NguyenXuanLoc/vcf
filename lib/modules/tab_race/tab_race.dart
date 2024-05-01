import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/tab_race/tab_race_bloc.dart';
import 'package:flutter/material.dart';

class TabRace extends StatefulWidget {
  const TabRace({Key? key}) : super(key: key);

  @override
  State<TabRace> createState() => _TabRaceState();
}

class _TabRaceState extends BaseState<TabRace, TabRaceBloc>
    with AutomaticKeepAliveClientMixin {
  @override
  void init() {}

  @override
  Widget build(BuildContext context) {
    return AppText(" TAB RACE");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  createCubit() => TabRaceBloc();

  @override
  void dispose() {
    super.dispose();
  }
}

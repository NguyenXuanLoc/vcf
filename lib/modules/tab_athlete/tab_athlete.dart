import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/modules/tab_athlete/tab_athlete_bloc.dart';
import 'package:flutter/material.dart';

class TabAthlete extends StatefulWidget {
  const TabAthlete({Key? key}) : super(key: key);

  @override
  State<TabAthlete> createState() => _TabAthleteState();
}

class _TabAthleteState extends BaseState<TabAthlete, TabAthleteBloc>
    with AutomaticKeepAliveClientMixin {
  @override
  void init() {}

  @override
  Widget build(BuildContext context) {
    return AppText(" TAB ATHLETE");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  createCubit() => TabAthleteBloc();

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/modules/tab_news/tab_news_state.dart';
import 'package:base_bloc/modules/tab_race/tab_race_state.dart';

class TabNewsBloc extends BaseCubit<TabNewsState> {
  TabNewsBloc() : super(const TabNewsState());
}

import 'package:equatable/equatable.dart';

import '../../data/model/news_model.dart';

class TabNewsState extends Equatable {
  final bool isReadEnd;
  final bool isLoading;
  final List<NewsModel> lNews;
  final int nextPage;

  const TabNewsState(
      {this.isReadEnd = false,
      this.isLoading = false,
      this.lNews = const [],
      this.nextPage = 1});

  TabNewsState copyOf(
          {List<String>? lMale,
          String? male,
          bool? isLoading,
          int? nextPage,
          bool? isReadEnd,
          List<NewsModel>? lNews}) =>
      TabNewsState(
          nextPage: nextPage ?? this.nextPage,
          isLoading: isLoading ?? this.isLoading,
          isReadEnd: isReadEnd ?? this.isReadEnd,
          lNews: lNews ?? this.lNews);

  @override
  List<Object?> get props => [nextPage, isLoading, isReadEnd, lNews];
}

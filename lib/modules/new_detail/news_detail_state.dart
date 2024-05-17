import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/data/model/news_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/news_detail_model.dart';

class NewsDetailState extends Equatable {
  final bool isNewsLoading;
  NewsModel? newsModel;
  final List<NewsModel> lRelated;
  final bool isRelatedLoading;
  final bool isRelatedReadEnd;
  final NewsDetailModel? newsDetailModel;
  final int nextPage;

  NewsDetailState(
      {this.isNewsLoading = false,
      this.nextPage = 1,
      this.isRelatedReadEnd = false,
      this.newsModel,
      this.newsDetailModel,
      this.lRelated = const [],
      this.isRelatedLoading = false});

  NewsDetailState copyOf(
          {bool? isNewsLoading,
          int? nextPage,
          NewsDetailModel? newsDetailModel,
          bool? isRelatedReadEnd,
          bool? isRelatedLoading,
          List<NewsModel>? lRelated,
          NewsModel? newsModel}) =>
      NewsDetailState(
          nextPage: nextPage ?? this.nextPage,
          newsDetailModel: newsDetailModel ?? this.newsDetailModel,
          isRelatedReadEnd: isRelatedReadEnd ?? this.isRelatedReadEnd,
          newsModel: newsModel ?? this.newsModel,
          isNewsLoading: isNewsLoading ?? this.isNewsLoading,
          isRelatedLoading: isRelatedLoading ?? this.isRelatedLoading,
          lRelated: lRelated ?? this.lRelated);

  @override
  List<Object?> get props => [
        nextPage,
        isNewsLoading,
        newsModel,
        lRelated,
        isRelatedLoading,
        isRelatedReadEnd,
        newsDetailModel
      ];
}

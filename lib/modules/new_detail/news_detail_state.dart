import 'package:base_bloc/data/model/athlete_model.dart';
import 'package:base_bloc/data/model/news_model.dart';
import 'package:equatable/equatable.dart';

class NewsDetailState extends Equatable {
  final bool isNewsLoading;
  final NewsModel? newsModel;
  final List<NewsModel> lRelated;
  final bool isRelatedLoading;
  final bool isRelatedReadEnd;

  const NewsDetailState(
      {this.isNewsLoading = false,
      this.isRelatedReadEnd = false,
      this.newsModel,
      this.lRelated = const [],
      this.isRelatedLoading = false});

  NewsDetailState copyOf(
          {bool? isNewsLoading,
          bool? isRelatedReadEnd,
          bool? isRelatedLoading,
          List<NewsModel>? lRelated,
          NewsModel? newsModel}) =>
      NewsDetailState(
          isRelatedReadEnd: isRelatedReadEnd ?? this.isRelatedReadEnd,
          newsModel: newsModel ?? this.newsModel,
          isNewsLoading: isNewsLoading ?? this.isNewsLoading,
          isRelatedLoading: isRelatedLoading ?? this.isRelatedLoading,
          lRelated: lRelated ?? this.lRelated);

  @override
  List<Object?> get props =>
      [isNewsLoading, newsModel, lRelated, isRelatedLoading, isRelatedReadEnd];
}

import 'package:base_bloc/data/model/race_detail_model.dart';
import 'package:base_bloc/data/model/tournament_detail_model.dart';
import 'package:equatable/equatable.dart';

class RoundDetailState extends Equatable {
  final bool isLoading;
  final RaceDetailModel? model;

  const RoundDetailState({this.isLoading = true, this.model});

  RoundDetailState copyOf({bool? isLoading, RaceDetailModel? model}) =>
      RoundDetailState(
          isLoading: isLoading ?? this.isLoading, model: model ?? this.model);

  @override
  List<Object?> get props => [isLoading, model];
}

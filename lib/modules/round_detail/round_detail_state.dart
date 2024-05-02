import 'package:base_bloc/data/model/tournament_detail_model.dart';
import 'package:equatable/equatable.dart';

class RoundDetailState extends Equatable {
  final bool isLoading;
  final TournamentDetailModel? model;

  const RoundDetailState({this.isLoading = true, this.model});

  RoundDetailState copyOf({bool? isLoading, TournamentDetailModel? model}) =>
      RoundDetailState(
          isLoading: isLoading ?? this.isLoading, model: model ?? this.model);

  @override
  List<Object?> get props => [isLoading, model];
}

import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final int index;
  final bool isNotify;
  final bool isRefreshUi;

  const HomeState(
      {this.index = 0, this.isNotify = false, this.isRefreshUi = false});

  HomeState copyOf({bool? isRefreshUi, int? index, bool? isNotify}) =>
      HomeState(
        isRefreshUi: isRefreshUi ?? this.isRefreshUi,
        isNotify: isNotify ?? this.isNotify,
        index: index ?? this.index,
      );

  @override
  List<Object?> get props => [index, isNotify, isRefreshUi];
}

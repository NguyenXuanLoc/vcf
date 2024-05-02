import 'package:equatable/equatable.dart';

class OnBoardingState extends Equatable {
  final bool isStartAnimation;

  const OnBoardingState({this.isStartAnimation = false});

  OnBoardingState copyOf({bool? isStartAnimation}) =>
      OnBoardingState(isStartAnimation: isStartAnimation ?? this.isStartAnimation);

  @override
  List<Object?> get props => [isStartAnimation];
}

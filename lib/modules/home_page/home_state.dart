import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeState extends Equatable {
  final int index;
  final bool isNotify;
  final RemoteMessage? remoteMessage;
  final bool isRefreshUi;

  const HomeState(
      {this.index = 0,
        this.isNotify = false,
        this.remoteMessage,
        this.isRefreshUi = false});

  HomeState copyOf(
      {bool? isRefreshUi,
        int? index,
        bool? isNotify,
        RemoteMessage? remoteMessage}) =>
      HomeState(
          isRefreshUi: isRefreshUi ?? this.isRefreshUi,
          isNotify: isNotify ?? this.isNotify,
          index: index ?? this.index,
          remoteMessage: remoteMessage ?? this.remoteMessage);

  @override
  List<Object?> get props => [index, isNotify, remoteMessage, isRefreshUi];
}

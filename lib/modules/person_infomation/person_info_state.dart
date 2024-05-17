import 'package:base_bloc/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class PersonInfoState extends Equatable {
  final String currentVer;
  final UserModel? userModel;
  final bool isRefresh;

  const PersonInfoState(
      {this.currentVer = '', this.userModel, this.isRefresh = false});

  PersonInfoState copyOf(
          {String? currentVer, UserModel? userModel, bool? isRefresh}) =>
      PersonInfoState(
          isRefresh: isRefresh ?? this.isRefresh,
          currentVer: currentVer ?? this.currentVer,
          userModel: userModel ?? this.userModel);

  @override
  List<Object?> get props => [currentVer, userModel, isRefresh];
}

import 'package:base_bloc/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class PersonInfoState extends Equatable {
  final String currentVer;
  final UserModel? userModel;

  const PersonInfoState({this.currentVer = '', this.userModel});

  PersonInfoState copyOf({String? currentVer, UserModel? userModel}) =>
      PersonInfoState(
          currentVer: currentVer ?? this.currentVer,
          userModel: userModel ?? this.userModel);

  @override
  List<Object?> get props => [currentVer, userModel];
}

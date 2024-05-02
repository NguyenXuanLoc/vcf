import 'package:base_bloc/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class UpdateProfileState extends Equatable {
  final bool isValidEmail;
  final bool isValidFullName;
  final bool isValidPhoneNumber;
  final bool isShowOldPass;
  final bool isShowNewPass;
  final UserModel? userModel;

  const UpdateProfileState(
      {this.isValidEmail = false,
      this.userModel,
      this.isShowOldPass = false,
      this.isShowNewPass = false,
      this.isValidFullName = false,
      this.isValidPhoneNumber = false});

  UpdateProfileState copyOf(
          {bool? isValidEmail,
          bool? isShowNewPass,
          UserModel? userModel,
          bool? isShowOldPass,
          bool? isValidFullName,
          bool? isValidPhoneNumber}) =>
      UpdateProfileState(
          userModel: userModel ?? this.userModel,
          isShowNewPass: isShowNewPass ?? this.isShowNewPass,
          isValidPhoneNumber: isValidPhoneNumber ?? this.isValidPhoneNumber,
          isValidFullName: isValidFullName ?? this.isValidFullName,
          isValidEmail: isValidEmail ?? this.isValidEmail,
          isShowOldPass: isShowOldPass ?? this.isShowOldPass);

  @override
  List<Object?> get props => [
        userModel,
        isValidEmail,
        isShowOldPass,
        isShowNewPass,
        isValidFullName,
        isValidPhoneNumber
      ];
}

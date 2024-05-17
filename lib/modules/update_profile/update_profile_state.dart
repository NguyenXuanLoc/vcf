import 'package:base_bloc/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class UpdateProfileState extends Equatable {
  final bool isValidEmail;
  final bool isValidFullName;
  final bool isValidPhoneNumber;
  final bool isShowOldPass;
  final bool isShowNewPass;
  UserModel? userModel;
  final String errorEmail;
  final String errorFullName;
  final String errorPhone;
  final String errorOldPass;
  final String errorNewPass;
  final bool isRefreshUi;
  final bool isEnableSaveButton;
   String? pathImage;

  UpdateProfileState refreshUI() => copyOf(isRefreshUi: !isRefreshUi);

  UpdateProfileState(
      {this.isValidEmail = false,
      this.isEnableSaveButton = false,
      this.pathImage,
      this.errorEmail = '',
      this.isRefreshUi = false,
      this.errorFullName = '',
      this.errorNewPass = '',
      this.errorOldPass = '',
      this.errorPhone = '',
      this.userModel,
      this.isShowOldPass = false,
      this.isShowNewPass = false,
      this.isValidFullName = false,
      this.isValidPhoneNumber = false});

  UpdateProfileState copyOf(
          {bool? isValidEmail,
          bool? isEnableSaveButton,
          String? errorEmail,
          String? pathImage,
          bool? isRefreshUi,
          String? errorFullName,
          String? errorPhone,
          String? errorOldPass,
          String? errorNewPass,
          bool? isShowNewPass,
          UserModel? userModel,
          bool? isShowOldPass,
          bool? isValidFullName,
          bool? isValidPhoneNumber}) =>
      UpdateProfileState(
          pathImage: pathImage ?? this.pathImage,
          isEnableSaveButton: isEnableSaveButton ?? this.isEnableSaveButton,
          isRefreshUi: isRefreshUi ?? this.isRefreshUi,
          errorOldPass: errorOldPass ?? this.errorOldPass,
          errorNewPass: errorNewPass ?? this.errorNewPass,
          errorFullName: errorFullName ?? this.errorFullName,
          errorEmail: errorEmail ?? this.errorEmail,
          errorPhone: errorPhone ?? this.errorPhone,
          userModel: userModel ?? this.userModel,
          isShowNewPass: isShowNewPass ?? this.isShowNewPass,
          isValidPhoneNumber: isValidPhoneNumber ?? this.isValidPhoneNumber,
          isValidFullName: isValidFullName ?? this.isValidFullName,
          isValidEmail: isValidEmail ?? this.isValidEmail,
          isShowOldPass: isShowOldPass ?? this.isShowOldPass);

  @override
  List<Object?> get props => [
        pathImage,
        isEnableSaveButton,
        errorEmail,
        isRefreshUi,
        errorFullName,
        errorOldPass,
        errorNewPass,
        errorPhone,
        userModel,
        isValidEmail,
        isShowOldPass,
        isShowNewPass,
        isValidFullName,
        isValidPhoneNumber
      ];
}

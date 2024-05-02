import 'package:equatable/equatable.dart';

class UpdateProfileState extends Equatable {
  final bool isValidEmail;
  final bool isValidFullName;
  final bool isValidPhoneNumber;
  final bool isShowOldPass;
  final bool isShowNewPass;

  const UpdateProfileState(
      {this.isValidEmail = false,
      this.isShowOldPass = false,
      this.isShowNewPass = false,
      this.isValidFullName = false,
      this.isValidPhoneNumber = false});

  UpdateProfileState copyOf(
          {bool? isValidEmail,
          bool? isShowNewPass,
          bool? isShowOldPass,
          bool? isValidFullName,
          bool? isValidPhoneNumber}) =>
      UpdateProfileState(
          isShowNewPass: isShowNewPass ?? this.isShowNewPass,
          isValidPhoneNumber: isValidPhoneNumber ?? this.isValidPhoneNumber,
          isValidFullName: isValidFullName ?? this.isValidFullName,
          isValidEmail: isValidEmail ?? this.isValidEmail,
          isShowOldPass: isShowOldPass ?? this.isShowOldPass);

  @override
  List<Object?> get props => [
        isValidEmail,
        isShowOldPass,
        isShowNewPass,
        isValidFullName,
        isValidPhoneNumber
      ];
}

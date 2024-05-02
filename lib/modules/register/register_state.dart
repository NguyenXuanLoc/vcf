import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool isValidEmail;
  final bool isValidFullName;
  final bool isShowPass;
  final String errorEmail;
  final String errorPass;
  final String errorFullName;

  const RegisterState(
      {this.errorEmail = '',
      this.errorFullName = '',
      this.errorPass = '',
      this.isValidEmail = false,
      this.isShowPass = false,
      this.isValidFullName = false});

  RegisterState copyOf(
          {String? errorEmail,
          String? errorPass,
          String? errorFullName,
          bool? isValidEmail,
          bool? isShowPass,
          bool? isValidFullName}) =>
      RegisterState(
          errorFullName: errorFullName ?? this.errorFullName,
          errorEmail: errorEmail ?? this.errorEmail,
          errorPass: errorPass ?? this.errorPass,
          isValidFullName: isValidFullName ?? this.isValidFullName,
          isValidEmail: isValidEmail ?? this.isValidEmail,
          isShowPass: isShowPass ?? this.isShowPass);

  @override
  List<Object?> get props => [
        isValidEmail,
        isShowPass,
        isValidFullName,
        errorEmail,
        errorPass,
        errorFullName
      ];
}

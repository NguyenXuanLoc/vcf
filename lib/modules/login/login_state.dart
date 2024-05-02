import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isValidEmail;
  final bool isShowPass;
  final String errorEmail;
  final String errorPass;

  const LoginState(
      {this.isValidEmail = false,
      this.isShowPass = false,
      this.errorEmail = '',
      this.errorPass = ''});

  LoginState copyOf(
          {bool? isValidEmail,
          bool? isShowPass,
          String? errorEmail,
          String? errorPass}) =>
      LoginState(
          errorPass: errorPass ?? this.errorPass,
          errorEmail: errorEmail ?? this.errorEmail,
          isValidEmail: isValidEmail ?? this.isValidEmail,
          isShowPass: isShowPass ?? this.isShowPass);

  @override
  List<Object?> get props => [isValidEmail, isShowPass, errorEmail, errorPass];
}

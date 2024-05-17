import 'package:equatable/equatable.dart';

class ForgotPassState extends Equatable {
  final bool isValidEmail;
  final bool isShowPass;
  final String errorEmail;

  ForgotPassState(
      {this.isValidEmail = false,
      this.isShowPass = false,
      this.errorEmail = ''});

  ForgotPassState copyOf(
          {bool? isValidEmail, bool? isShowPass, String? errorEmail}) =>
      ForgotPassState(
          errorEmail: errorEmail ?? this.errorEmail,
          isValidEmail: isValidEmail ?? this.isValidEmail,
          isShowPass: isShowPass ?? this.isShowPass);

  @override
  List<Object?> get props => [errorEmail, isValidEmail, isShowPass];
}

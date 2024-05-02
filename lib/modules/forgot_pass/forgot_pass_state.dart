import 'package:equatable/equatable.dart';

class ForgotPassState extends Equatable {
  final bool isValidEmail;
  final bool isShowPass;

  const ForgotPassState({this.isValidEmail = false, this.isShowPass = false});

  ForgotPassState copyOf({bool? isValidEmail, bool? isShowPass}) => ForgotPassState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isShowPass: isShowPass ?? this.isShowPass);

  @override
  List<Object?> get props => [isValidEmail, isShowPass];
}

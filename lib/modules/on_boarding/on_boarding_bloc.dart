import 'package:base_bloc/modules/login/login_page.dart';
import 'package:base_bloc/modules/on_boarding/on_boarding_state.dart';
import 'package:base_bloc/modules/register/register_page.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBloc extends Cubit<OnBoardingState> {
  OnBoardingBloc() : super(const OnBoardingState()) {}

  void registerOnClick(BuildContext context) {
    RouterUtils.pushTo(context, const RegisterPage());
  }

  void loginOnClick(BuildContext context) {
    RouterUtils.pushTo(context, const LoginPage());
  }
}

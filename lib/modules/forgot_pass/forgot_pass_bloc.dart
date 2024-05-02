import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/modules/forgot_pass/forgot_pass_state.dart';
import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/modules/login/login_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/email_validate.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassBloc extends Cubit<ForgotPassState> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  ForgotPassBloc() : super(ForgotPassState());

  void emailOnChange(String text) {
    emit(state.copyOf(isValidEmail: EmailValidator.validate(text)));
  }

  void forgotOnClick(BuildContext context) {
    toast("GUI THONG TIN THANH CONG");
  }

  void showPass() => emit(state.copyOf(isShowPass: !state.isShowPass));
}

import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/modules/forgot_pass/forgot_pass_state.dart';
import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/modules/login/login_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/email_validate.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/dialogs.dart';
import '../../generated/locale_keys.g.dart';

class ForgotPassBloc extends BaseCubit<ForgotPassState> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  ForgotPassBloc() : super(ForgotPassState());

  void emailOnChange(String text) {
    emit(state.copyOf(isValidEmail: EmailValidator.validate(text)));
  }

  bool isValid() {
    var email = emailController.text;
    var pass = passController.text;
    var isValid = true;
    if (email.isEmpty) {
      emit(state.copyOf(errorEmail: LocaleKeys.please_input_email.tr()));
      isValid = false;
    } else if (!EmailValidator.validate(emailController.text)) {
      emit(state.copyOf(errorEmail: LocaleKeys.please_input_valid_email.tr()));
      isValid = false;
    } else {
      emit(state.copyOf(errorEmail: ''));
    }
    return isValid;
  }

  void forgotOnClick(BuildContext context) async {
    if (isValid()) {
      Dialogs.showLoadingDialog(context);
      var response = await repository.forgotPass(emailController.text);
      await Dialogs.hideLoadingDialog();
      if (response.error != null) {
        toast(response.error.toString());
      } else {
        toast(response.message.toString());
      }
    }
  }

  void showPass() => emit(state.copyOf(isShowPass: !state.isShowPass));
}

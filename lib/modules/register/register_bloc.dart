import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/modules/login/login_page.dart';
import 'package:base_bloc/modules/register/register_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../components/dialogs.dart';
import '../../generated/locale_keys.g.dart';
import '../../utils/app_utils.dart';
import '../../utils/email_validate.dart';

class RegisterBloc extends BaseCubit<RegisterState> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var fullNameController = TextEditingController();

  RegisterBloc() : super(const RegisterState()) {
    // fakeData();
  }

  void fakeData() {
    emailController.text = 'loc311121998@gmail.com';
    passController.text = 'Loc3121@';
    fullNameController.text = 'CUK';
  }

  void emailValidate(String text) =>
      emit(state.copyOf(isValidEmail: EmailValidator.validate(text)));

  void fullNameValidate(String text) =>
      emit(state.copyOf(isValidFullName: text.isNotEmpty));

  void showPass() => emit(state.copyOf(isShowPass: !state.isShowPass));

  void registerOnClick(BuildContext context) async {
    if (isValid()) {
      Dialogs.showLoadingDialog(context);
      var response = await repository.registerWithEmail(
          emailController.text, passController.text, fullNameController.text);
      await Dialogs.hideLoadingDialog();
      if (response.error == null) {
        toast(response.message.toString());
        RouterUtils.pushTo(context, LoginPage());
      } else {
        toast(response.error.toString());
      }
    }
  }

  bool isValid() {
    var email = emailController.text;
    var pass = passController.text;
    var fullName = fullNameController.text;
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

    if (fullName.isEmpty) {
      emit(state.copyOf(errorFullName: LocaleKeys.please_input_full_name.tr()));
      isValid = false;
    } else {
      emit(state.copyOf(errorFullName: ''));
    }

    if (pass.isEmpty) {
      emit(state.copyOf(errorPass: LocaleKeys.please_input_pass.tr()));
      isValid = false;
    } else if (!Utils.validatePassword(passController.text)) {
      emit(state.copyOf(errorPass: LocaleKeys.please_input_valid_pass.tr()));
      isValid = false;
    } else {
      emit(state.copyOf(errorPass: ''));
    }
    return isValid;
  }
}

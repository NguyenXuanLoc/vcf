import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/model/user_model.dart';
import 'package:base_bloc/generated/locale_keys.g.dart';
import 'package:base_bloc/modules/forgot_pass/forgot_pass_page.dart';
import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/modules/login/login_state.dart';
import 'package:base_bloc/modules/register/register_page.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/email_validate.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../components/dialogs.dart';

class LoginBloc extends BaseCubit<LoginState> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  LoginBloc() : super(LoginState()) {
    fakeData();
  }

  void fakeData() {
    emailController.text = 'loc311121998@gmail.com';
    passController.text = 'Loc3121@';
  }

  void emailOnChange(String text) {
    emit(state.copyOf(isValidEmail: EmailValidator.validate(text)));
  }

  void forgotOnClick(BuildContext context) {
    RouterUtils.pushTo(context, const ForgotPassPage());
  }

  void registerOnClick(BuildContext context) {
    RouterUtils.pushTo(context, const RegisterPage());
  }

  void loginOnClick(BuildContext context) async {
    if (isValid()) {
      Dialogs.showLoadingDialog(context);
      var response = await repository.loginWithEmail(
          emailController.text, passController.text);
      if (response.error != null) {
        await Dialogs.hideLoadingDialog();
        toast(response.error.toString());
      } else {
        StorageUtils.saveLogin(response.data[ApiKey.token]);
        var userResponse = await repository.getUserProfile();
        await Dialogs.hideLoadingDialog();
        if (userResponse.error == null) {
          var userModel = UserModel.fromJson(userResponse.data);
          StorageUtils.saveUserModel(userModel);
        }
        RouterUtils.pushTo(context, const HomePage(), isReplace: true);
      }
    }
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

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    var credential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    logE(
        "TAG signInWithFacebook credential: ${credential.credential?.accessToken}");
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    var credentiaTESl =
        await FirebaseAuth.instance.signInWithCredential(credential);
    logE(
        "TAG signInWithGoogle credential: ${credentiaTESl.credential?.accessToken}");

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void showPass() => emit(state.copyOf(isShowPass: !state.isShowPass));
}

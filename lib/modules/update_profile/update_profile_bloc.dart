import 'package:base_bloc/modules/update_profile/update_profile_state.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_utils.dart';
import '../../utils/email_validate.dart';

class UpdateProfileBloc extends Cubit<UpdateProfileState> {
  var emailController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();

  UpdateProfileBloc() : super(UpdateProfileState()) {
    getUserProfile();
  }

  void getUserProfile() async {
    var userModel = await StorageUtils.getUserInfo();
    emailController.text = userModel?.email ?? '';
    phoneNumberController.text = userModel?.phone ?? '';
    fullNameController.text =
        "${userModel?.firstName ?? ''} ${userModel?.lastName ?? ''}";
    emit(state.copyOf(userModel: userModel));
  }

  void emailValidate(String text) =>
      emit(state.copyOf(isValidEmail: EmailValidator.validate(text)));

  void fullNameValidate(String text) =>
      emit(state.copyOf(isValidFullName: text.isNotEmpty));

  void phoneNumberValidate(String text) =>
      emit(state.copyOf(isValidPhoneNumber: Utils.validateMobile(text)));

  void showOldPass() => emit(state.copyOf(isShowOldPass: !state.isShowOldPass));

  void showNewPass() => emit(state.copyOf(isShowNewPass: !state.isShowNewPass));
}

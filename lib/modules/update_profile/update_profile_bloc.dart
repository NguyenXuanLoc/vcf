import 'package:base_bloc/base/base_cubit.dart';
import 'package:base_bloc/components/dialogs.dart';
import 'package:base_bloc/data/eventbus/refresh_event.dart';
import 'package:base_bloc/modules/update_profile/update_profile_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../generated/locale_keys.g.dart';
import '../../utils/app_utils.dart';
import '../../utils/email_validate.dart';

class UpdateProfileBloc extends BaseCubit<UpdateProfileState> {
  var emailController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();

  UpdateProfileBloc() : super(UpdateProfileState()) {
    getUserProfile();
  }

  void saveOnClick(BuildContext context) async {
    if (await isValid()) {
      Dialogs.showLoadingDialog(context);
      await uploadImage();
      var response = await repository.updateProfile(
          email: emailController.text,
          fullName: fullNameController.text,
          phone: phoneNumberController.text,
          newPass: newPassController.text);
      await Dialogs.hideLoadingDialog();
      if (response.error == null) {
        toast(response.message.toString());
        var userModel = await StorageUtils.getUserInfo();
        var newInfo = userModel?.copyOf(
            email: emailController.text,
            firstName: fullNameController.text,
            phone: phoneNumberController.text);
        if (newPassController.text.isNotEmpty) {
          StorageUtils.saveOldPass(newPassController.text);
        }
        newPassController.text = '';
        oldPassController.text = '';
        state.userModel = newInfo;
        if (newInfo != null) StorageUtils.saveUserModel(newInfo);
        emit(state.copyOf(isEnableSaveButton: isSameDataWithOldValue()));
      } else {
        toast(response.error.toString());
      }
    }
  }

  Future<bool> isValid() async {
    var email = emailController.text;
    var oldPass = oldPassController.text;
    var newPass = newPassController.text;
    var phone = phoneNumberController.text;
    var fullName = fullNameController.text;
    var isValid = true;
    if (fullName.isEmpty || fullName.trim().isEmpty) {
      emit(state.copyOf(errorFullName: LocaleKeys.please_input_full_name.tr()));
      isValid = false;
    } else {
      emit(state.copyOf(errorFullName: ''));
    }
    if (email.isEmpty) {
      emit(state.copyOf(errorEmail: LocaleKeys.please_input_email.tr()));
      isValid = false;
    } else if (!EmailValidator.validate(emailController.text)) {
      emit(state.copyOf(errorEmail: LocaleKeys.please_input_valid_email.tr()));
      isValid = false;
    } else {
      emit(state.copyOf(errorEmail: ''));
    }
    if (oldPass.isNotEmpty && !Utils.validatePassword(oldPass)) {
      emit(state.copyOf(errorOldPass: LocaleKeys.please_input_valid_pass.tr()));
      isValid = false;
    } else {
      emit(state.copyOf(errorOldPass: ''));
    }

    if (newPass.isNotEmpty && !Utils.validatePassword(newPass)) {
      emit(state.copyOf(errorNewPass: LocaleKeys.please_input_valid_pass.tr()));
      isValid = false;
    } else {
      emit(state.copyOf(errorNewPass: ''));
    }
    if (Utils.validatePassword(newPass) && oldPass.isEmpty) {
      emit(state.copyOf(errorOldPass: LocaleKeys.please_input_valid_pass.tr()));
      isValid = false;
    }
    if (Utils.validatePassword(oldPass) && newPass.isEmpty) {
      emit(state.copyOf(errorNewPass: LocaleKeys.please_input_valid_pass.tr()));
      isValid = false;
    }
    if (Utils.validatePassword(oldPass)) {
      var oldPassCache = await StorageUtils.getOldPass();
      if (oldPassCache != null &&
          oldPassCache.isNotEmpty &&
          oldPassCache != oldPass) {
        isValid = false;
        emit(state.copyOf(errorOldPass: LocaleKeys.old_pass_is_not_valid.tr()));
      } else {
        emit(state.copyOf(errorOldPass: ''));
      }
    }
    if (phone.isEmpty) {
      emit(state.copyOf(errorPhone: LocaleKeys.please_input_phone.tr()));
      isValid = false;
    } else if (!Utils.validateMobile(phone)) {
      emit(state.copyOf(errorPhone: LocaleKeys.phone_is_not_valid.tr()));
      isValid = false;
    } else {
      emit(state.copyOf(errorPhone: ''));
    }
    return isValid && !isSameDataWithOldValue();
  }

  Future<void> uploadImage() async {
    if ((state.pathImage ?? '').isEmpty) return;
    var response = await repository.uploadAvatar(state.pathImage ?? '');
    if (response.error == null) {
      var avatar = response.data['avatar'];
      var userModel = await StorageUtils.getUserInfo();
      if (userModel != null) {
        var newUserInfoModel = userModel.copyOf(avatar: avatar);
        state.userModel = newUserInfoModel;
        await StorageUtils.saveUserModel(newUserInfoModel);
        Utils.fireEvent(RefreshEvent(refreshType: RefreshType.HOME));
        state.pathImage = null;
        emit(state.copyOf(isEnableSaveButton: isSameDataWithOldValue()));
      }
    } else {
      toast(response.error.toString());
    }
  }

  void passOnChange() {
    emit(state.copyOf(isEnableSaveButton: isSameDataWithOldValue()));
  }

  bool isSameDataWithOldValue() {
    var email = emailController.text;
    var phone = phoneNumberController.text;
    var fullName = fullNameController.text;
    return (email == state.userModel?.email &&
        phone == state.userModel?.phone &&
        fullName == state.userModel?.firstName &&
        newPassController.text.isEmpty &&
        oldPassController.text.isEmpty &&
        (state.pathImage ?? '').isEmpty);
  }

  void cancelOnClick() {
    oldPassController.text = '';
    newPassController.text = '';
    emit(UpdateProfileState());
    getUserProfile();
  }

  void getUserProfile() async {
    var userModel = await StorageUtils.getUserInfo();
    emailController.text = userModel?.email ?? '';
    phoneNumberController.text = userModel?.phone ?? '';
    fullNameController.text = userModel?.firstName ?? '';
    state.userModel = userModel;
    emit(state.copyOf(
        userModel: userModel, isEnableSaveButton: isSameDataWithOldValue()));
    emailValidate(emailController.text);
    fullNameValidate(fullNameController.text);
    phoneNumberValidate(phoneNumberController.text);
  }

  void emailValidate(String text) => emit(state.copyOf(
      isValidEmail: EmailValidator.validate(text),
      isEnableSaveButton: isSameDataWithOldValue()));

  void fullNameValidate(String text) => emit(state.copyOf(
      isValidFullName: text.isNotEmpty,
      isEnableSaveButton: isSameDataWithOldValue()));

  void phoneNumberValidate(String text) => emit(state.copyOf(
      isValidPhoneNumber: Utils.validateMobile(text),
      isEnableSaveButton: isSameDataWithOldValue()));

  void showOldPass() => emit(state.copyOf(
      isShowOldPass: !state.isShowOldPass,
      isEnableSaveButton: isSameDataWithOldValue()));

  void showNewPass() => emit(state.copyOf(
      isShowNewPass: !state.isShowNewPass,
      isEnableSaveButton: isSameDataWithOldValue()));

  void avatarOnclick() async {
    var image = await Utils.openPicker();
    if (image != null) {
      state.pathImage = image.path;
      emit(state.copyOf(
          isRefreshUi: !state.isRefreshUi,
          isEnableSaveButton: isSameDataWithOldValue()));
    }
  }
}

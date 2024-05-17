import 'dart:io';

import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_network_image.dart';
import 'package:base_bloc/modules/update_profile/update_profile_bloc.dart';
import 'package:base_bloc/modules/update_profile/update_profile_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../base/hex_color.dart';
import '../../components/app_bar_widget.dart';
import '../../components/app_button.dart';
import '../../components/app_scalford.dart';
import '../../components/app_text.dart';
import '../../components/app_text_field.dart';
import '../../components/gradient_button.dart';
import '../../components/gradient_text.dart';
import '../../data/globals.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

enum ItemType { Email, FullName, PhoneNumber, OldPass, NewPass }

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState
    extends BaseState<UpdateProfilePage, UpdateProfileBloc> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      resizeToAvoidBottomInset: true,
      isTabToHideKeyboard: true,
      isFullScreen: true,
      body: Stack(
        children: [
          Image.asset(Assets.png.loginBackground.path,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space(height: MediaQuery.of(context).padding.top),
              appbar(),
              Expanded(
                child: SingleChildScrollView(
                    reverse: false,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: contentPadding, right: contentPadding),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        space(height: 30),
                        avatarWidget(),
                        space(),
                        for (var e in itemWidget(LocaleKeys.Email.tr(),
                            itemType: ItemType.Email,
                            controller: bloc.emailController,
                            onChange: (text) => bloc.emailValidate(text)))
                          e,
                        for (var e in itemWidget(LocaleKeys.Full_Name.tr(),
                            itemType: ItemType.FullName,
                            controller: bloc.fullNameController,
                            onChange: (text) => bloc.fullNameValidate(text)))
                          e,
                        for (var e in itemWidget(LocaleKeys.Phone_number.tr(),
                            itemType: ItemType.PhoneNumber,
                            textInputType: TextInputType.phone,
                            controller: bloc.phoneNumberController,
                            onChange: (text) => bloc.phoneNumberValidate(text)))
                          e,
                        for (var e in itemWidget(LocaleKeys.Old_pass.tr(),
                            itemType: ItemType.OldPass,
                            controller: bloc.oldPassController,
                            onChange: (text) => bloc.passOnChange()))
                          e,
                        for (var e in itemWidget(LocaleKeys.New_pass.tr(),
                            textInputAction: TextInputAction.done,
                            itemType: ItemType.NewPass,
                            controller: bloc.newPassController,
                            onChange: (text) => bloc.passOnChange()))
                          e,
                        space(height: 60),
                        saveButton,
                        space()
                      ]),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget registerNowWidget() => Text.rich(TextSpan(
          text: LocaleKeys.Do_you_already_have_an_account.tr(),
          style: typoW500.copyWith(fontSize: 12, color: colorWhite),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => print('Tap Here onTap'),
                text: LocaleKeys.login_now.tr(),
                style:
                    typoW500.copyWith(fontSize: 12, color: HexColor('0093DD')))
          ]));

  Widget loginWithButton(String title, String svgIcon) => AppButton(
        backgroundColor: colorWhite,
        borderRadius: 12,
        onPress: () {},
        height: 48,
        titleWidget: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(svgIcon),
              const SizedBox(width: 10),
              Flexible(
                  child: AppText(title,
                      style: typoW600.copyWith(fontSize: 14), maxLine: 1))
            ],
          ),
        ),
      );

  List<Widget> itemWidget(String title,
          {TextInputAction textInputAction = TextInputAction.next,
          required ItemType itemType,
          required TextEditingController controller,
          required Function(String) onChange,
          TextInputType? textInputType}) =>
      [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(title,
              style:
                  typoW500.copyWith(fontSize: 12, color: HexColor('DEDEDE'))),
        ),
        space(height: 10),
        BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
            builder: (c, state) => AppTextField(
                readOnly: itemType == ItemType.Email &&
                        (state.userModel?.email ?? '').isNotEmpty
                    ? true
                    : false,
                textInputType: textInputType,
                onChanged: (text) => onChange.call(text),
                controller: controller,
                obscureText: itemType == ItemType.NewPass
                    ? !state.isShowNewPass
                    : (itemType == ItemType.OldPass
                        ? state.isShowOldPass
                        : null),
                textInputAction: textInputAction,
                textStyle: typoW500.copyWith(fontSize: 14, color: colorWhite),
                errorText: getErrorText(state, itemType),
                decoration: InputDecoration(
                    suffixIconConstraints:
                        const BoxConstraints(minWidth: 20, minHeight: 20),
                    suffixIcon: Padding(
                        padding: EdgeInsets.only(right: contentPadding),
                        child: getSuffixIcon(state, itemType)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("DEDEDE")),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("DEDEDE")),
                        borderRadius: BorderRadius.circular(12)))),
            bloc: bloc)
      ];

  String getErrorText(UpdateProfileState state, ItemType itemType) {
    switch (itemType) {
      case ItemType.Email:
        return state.errorEmail;
      case ItemType.NewPass:
        return state.errorNewPass;
      case ItemType.FullName:
        return state.errorFullName;
      case ItemType.OldPass:
        return state.errorOldPass;
      case ItemType.PhoneNumber:
        return state.errorPhone;
    }
  }

  Widget getSuffixIcon(UpdateProfileState state, ItemType itemType) {
    switch (itemType) {
      case ItemType.Email:
        return SvgPicture.asset(Assets.svg.icCheck,
            color: state.isValidEmail ? null : colorTransparent);
      case ItemType.FullName:
        return SvgPicture.asset(Assets.svg.icCheck,
            color: state.isValidFullName ? null : colorTransparent);
      case ItemType.PhoneNumber:
        return SvgPicture.asset(Assets.svg.icCheck,
            color: state.isValidPhoneNumber ? null : colorTransparent);
      case ItemType.NewPass:
        return InkWell(
            onTap: () => bloc.showNewPass(),
            child: SvgPicture.asset(state.isShowNewPass
                ? Assets.svg.icEyes
                : Assets.svg.icBlockEyes));
      case ItemType.OldPass:
        return InkWell(
            onTap: () => bloc.showOldPass(),
            child: SvgPicture.asset(state.isShowOldPass
                ? Assets.svg.icEyes
                : Assets.svg.icBlockEyes));
    }
  }

  Widget avatarWidget() => InkWell(
      onTap: () => bloc.avatarOnclick(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
              width: 85,
              height: 85,
              child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                  bloc: bloc,
                  builder: (c, state) =>
                      state.pathImage != null && state.pathImage!.isNotEmpty
                          ? Image.file(File(state.pathImage ?? ''),
                              fit: BoxFit.cover)
                          : (state.userModel?.avatar ?? '').isNotEmpty
                              ? AppNetworkImage(
                                  source: state.userModel?.avatar,
                                  errorWidget: defaultAvatarWidget())
                              : defaultAvatarWidget()))));

  Widget defaultAvatarWidget() => Image.asset(Assets.png.icDefaultAvatar.path);

  Widget appbar() => MainAppbarWidget(
      context: context,
      title: LocaleKeys.Update.tr(),
      action: InkWell(
          child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
              child: GradientText(LocaleKeys.Cancel.tr(),
                  style: typoW500.copyWith(fontSize: 14))),
          onTap: () => bloc.cancelOnClick()));

  Widget get saveButton => BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
      builder: (c, state) => GradientButton(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: state.isEnableSaveButton
                      ? [
                          Colors.grey.withOpacity(0.9),
                          Colors.grey.withOpacity(0.9)
                        ]
                      : [HexColor('38BAEA'), HexColor('4869F0')])),
          width: MediaQuery.of(context).size.width,
          onTap: () => bloc.saveOnClick(context),
          isCenter: true,
          widget: AppText(LocaleKeys.Save_change.tr(),
              style: typoW700.copyWith(fontSize: 16, color: colorWhite))),
      bloc: bloc);

  Widget space({double? height}) => SizedBox(height: height ?? 17);

  @override
  UpdateProfileBloc createCubit() => UpdateProfileBloc();

  @override
  void init() {}
}

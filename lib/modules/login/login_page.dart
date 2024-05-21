import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_bar_widget.dart';
import 'package:base_bloc/components/app_button.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/modules/login/login_bloc.dart';
import 'package:base_bloc/modules/login/login_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/gradient_button.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

enum ItemType { Email, Pass }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginBloc> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isTabToHideKeyboard: true,
      padding: EdgeInsets.zero,
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
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: contentPadding, right: contentPadding),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    space(height: 30),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: TitleWidget(
                            title: LocaleKeys.Welcome_back.tr(), size: 20)),
                    space(height: 40),
                    for (var e in itemWidget(LocaleKeys.Email.tr(),
                        itemType: ItemType.Email,
                        controller: bloc.emailController,
                        onChange: (text) => bloc.emailOnChange(text)))
                      e,
                    for (var e in itemWidget(LocaleKeys.Pass.tr(),
                        textInputAction: TextInputAction.done,
                        itemType: ItemType.Pass,
                        controller: bloc.passController,
                        onChange: (text) {}))
                      e,
                    space(),
                    forgotPassWidget,
                    space(height: 35),
                    loginButton,
                    space(),
             /*       orWidget,
                    space(height: 20),
                    loginWithButton(
                        LocaleKeys.Sign_in_with_your_Google_account.tr(),
                        Assets.svg.icGg,
                        () => bloc.signInWithGoogle()),
                    space(),
                    loginWithButton(
                        LocaleKeys.Log_in_with_your_Facebook_account.tr(),
                        Assets.svg.icFb,
                        () => bloc.signInWithFacebook()),
                    space(height: 20),*/
                    registerNowWidget()
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
          text: "${LocaleKeys.do_not_you_have_acc.tr()} ",
          style: typoW500.copyWith(fontSize: 12, color: colorWhite),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => bloc.registerOnClick(context),
                text: LocaleKeys.register_new.tr(),
                style:
                    typoW500.copyWith(fontSize: 12, color: HexColor('0093DD')))
          ]));

  Widget loginWithButton(
          String title, String svgIcon, VoidCallback buttonOnClick) =>
      AppButton(
        backgroundColor: colorWhite,
        borderRadius: 12,
        onPress: () => buttonOnClick.call(),
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

  Widget get orWidget => Row(children: [
        Expanded(
            child: Container(
                width: double.infinity, height: 1, color: colorWhite)),
        AppText("  ${LocaleKeys.Or.tr()}  ",
            style: typoW500.copyWith(fontSize: 14, color: colorWhite)),
        Expanded(
            child:
                Container(width: double.infinity, height: 1, color: colorWhite))
      ]);

  Widget get forgotPassWidget => InkWell(
      onTap: () => bloc.forgotOnClick(context),
      child: AppText(LocaleKeys.Forgot_your_password.tr(),
          style: typoW400.copyWith(
              fontSize: 12,
              color: colorWhite,
              decoration: TextDecoration.underline)));

  List<Widget> itemWidget(String title,
          {TextInputAction textInputAction = TextInputAction.next,
          required ItemType itemType,
          required TextEditingController controller,
          required Function(String) onChange}) =>
      [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(title,
              style:
                  typoW500.copyWith(fontSize: 12, color: HexColor('DEDEDE'))),
        ),
        space(height: 10),
        BlocBuilder<LoginBloc, LoginState>(
            builder: (c, state) => AppTextField(
                errorText: itemType == ItemType.Pass
                    ? state.errorPass
                    : state.errorEmail,
                onChanged: (text) => onChange.call(text),
                controller: controller,
                obscureText:
                    itemType == ItemType.Pass ? !state.isShowPass : null,
                textInputAction: textInputAction,
                textStyle: typoW500.copyWith(fontSize: 14, color: colorWhite),
                decoration: InputDecoration(
                    suffixIconConstraints:
                        const BoxConstraints(minWidth: 20, minHeight: 20),
                    suffixIcon: Padding(
                        padding: EdgeInsets.only(right: contentPadding),
                        child: itemType == ItemType.Email
                            ? SvgPicture.asset(Assets.svg.icCheck,
                                color: state.isValidEmail
                                    ? null
                                    : colorTransparent)
                            : InkWell(
                                onTap: () => bloc.showPass(),
                                child: SvgPicture.asset(state.isShowPass
                                    ? Assets.svg.icEyes
                                    : Assets.svg.icBlockEyes))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("DEDEDE")),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("DEDEDE")),
                        borderRadius: BorderRadius.circular(12)))),
            bloc: bloc)
      ];

  Widget appbar() => MainAppbarWidget(
      context: context,
      title: LocaleKeys.Login.tr(),
      action: Image.asset(Assets.png.icApp.path,
          width: 66, height: 66, fit: BoxFit.cover));

  Widget get loginButton => GradientButton(
      width: MediaQuery.of(context).size.width,
      onTap: () => bloc.loginOnClick(context),
      isCenter: true,
      widget: AppText(LocaleKeys.Login.tr(),
          style: typoW700.copyWith(fontSize: 16, color: colorWhite)));

  Widget space({double? height}) => SizedBox(height: height ?? 17);

  @override
  LoginBloc createCubit() => LoginBloc();

  @override
  void init() {}
}

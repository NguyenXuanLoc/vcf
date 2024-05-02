import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/components/app_bar_widget.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/modules/register/register_bloc.dart';
import 'package:base_bloc/modules/register/register_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../base/hex_color.dart';
import '../../components/app_button.dart';
import '../../components/app_text.dart';
import '../../components/app_text_field.dart';
import '../../components/gradient_button.dart';
import '../../data/globals.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../theme/app_styles.dart';
import '../../theme/colors.dart';

enum ItemType { Email, FullName, Pass }

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterBloc> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      isTabToHideKeyboard: true,
      resizeToAvoidBottomInset: true,
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: TitleWidget(
                                title: LocaleKeys.Join_us.tr(), size: 20)),
                        space(height: 5),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              LocaleKeys.Create_an_account_to_become_a_member
                                  .tr(),
                              style:
                                  typoW400.copyWith(color: HexColor('DEDEDE')),
                            )),
                        space(height: 55),
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
                        for (var e in itemWidget(LocaleKeys.Pass.tr(),
                            textInputAction: TextInputAction.done,
                            itemType: ItemType.Pass,
                            controller: bloc.passController,
                            onChange: (text) {}))
                          e,
                        space(height: 120),
                        registerButton
                      ]),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

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
        BlocBuilder<RegisterBloc, RegisterState>(
            builder: (c, state) => AppTextField(
                errorText: itemType == ItemType.FullName
                    ? state.errorFullName
                    : itemType == ItemType.Pass
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
                            : itemType == ItemType.FullName
                                ? SvgPicture.asset(Assets.svg.icCheck,
                                    color: state.isValidFullName
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
      title: LocaleKeys.Create_Account.tr(),
      action: Image.asset(Assets.png.icApp.path,
          width: 66, height: 66, fit: BoxFit.cover));

  Widget get registerButton => GradientButton(
      width: MediaQuery.of(context).size.width,
      onTap: () => bloc.registerOnClick(context),
      isCenter: true,
      widget: AppText(LocaleKeys.Register_an_Account.tr(),
          style: typoW700.copyWith(fontSize: 16, color: colorWhite)));

  Widget space({double? height}) => SizedBox(height: height ?? 17);

  @override
  RegisterBloc createCubit() => RegisterBloc();

  @override
  void init() {}
}

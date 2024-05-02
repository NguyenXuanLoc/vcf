import 'package:base_bloc/base/base_state.dart';
import 'package:base_bloc/base/hex_color.dart';
import 'package:base_bloc/components/app_bar_widget.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:base_bloc/components/title_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/modules/forgot_pass/forgot_pass_bloc.dart';
import 'package:base_bloc/modules/forgot_pass/forgot_pass_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/gradient_button.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

enum ItemType { Email, Pass }

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends BaseState<ForgotPassPage, ForgotPassBloc> {
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
                            title: LocaleKeys.input_email.tr(), size: 20)),
                    space(height: 40),
                    for (var e in itemWidget(LocaleKeys.Email.tr(),
                        itemType: ItemType.Email,
                        controller: bloc.emailController,
                        onChange: (text) => bloc.emailOnChange(text)))
                      e,
                    space(),
                    loginButton
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
        BlocBuilder<ForgotPassBloc, ForgotPassState>(
            builder: (c, state) => AppTextField(
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
      title: LocaleKeys.forgot_pass.tr(),
      action: Image.asset(Assets.png.icApp.path,
          width: 66, height: 66, fit: BoxFit.cover));

  Widget get loginButton => GradientButton(
      width: MediaQuery.of(context).size.width,
      onTap: () => bloc.forgotOnClick(context),
      isCenter: true,
      widget: AppText(LocaleKeys.Forgot_your_password.tr(),
          style: typoW700.copyWith(fontSize: 16, color: colorWhite)));

  Widget space({double? height}) => SizedBox(height: height ?? 17);

  @override
  ForgotPassBloc createCubit() => ForgotPassBloc();

  @override
  void init() {}
}

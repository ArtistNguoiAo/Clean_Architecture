import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risky_coin/presentation/common/text_field_common.dart';
import 'package:risky_coin/presentation/route/app_router.gr.dart';
import 'package:risky_coin/presentation/screen/login_screen/bloc/login_bloc.dart';
import 'package:risky_coin/presentation/utils/color_utils.dart';
import 'package:risky_coin/presentation/utils/dialog_helper.dart';
import 'package:risky_coin/presentation/utils/text_style_utils.dart';
import 'package:risky_coin/presentation/utils/text_utils.dart';


@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(LoginEventInit()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if(state is LoginStateLoaded) {
            emailController.text = '';
            passwordController.text = '';
          }
          if(state is LoginStateLoginSuccess) {
            DialogHelper.hideLoadingDialog(context);
            AutoRouter.of(context).replace(const HomeRoute());
          }
          if(state is LoginStateLoading) {
            DialogHelper.showLoadingDialog(context);
          }
          if(state is LoginStateError) {
            DialogHelper.hideLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: _body(context),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    LoginState state = context.select((LoginBloc bloc) => bloc.state);
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _emailTextField(),
                  _sizeBoxH16(),
                  _passwordTextField(),
                  _sizeBoxH16(),
                  if(state is LoginStateError) ...[
                    _errorText(state.message),
                  ],
                  _buttonLogin(context),
                  _sizeBoxH16(),
                  _buttonRegister(context),
                ],
              ),
            )
        )
    );
  }

  Widget _emailTextField() {
    return TextFieldCommon(
      style: TextStyleUtils.textStyleNunitoS18W500Black,
      hintText: TextUtils.email,
      prefixIcon: const Icon(
        FontAwesomeIcons.at,
        color: ColorUtils.primaryColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorUtils.primaryColor),
      ),
      controller: emailController,
    );
  }

  Widget _passwordTextField() {
    return TextFieldCommon(
      hintText: TextUtils.password,
      style: TextStyleUtils.textStyleNunitoS18W500Black,
      prefixIcon: const Icon(
        FontAwesomeIcons.lock,
        color: ColorUtils.primaryColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorUtils.primaryColor),
      ),
      obscureText: true,
      controller: passwordController,
    );
  }

  Widget _sizeBoxH16() {
    return const SizedBox(height: 16);
  }

  Widget _buttonLogin(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<LoginBloc>().add(
          LoginEventLogin(
            email: emailController.text,
            password: passwordController.text,
          )
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        decoration: BoxDecoration(
          color: ColorUtils.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(32)),
          border: Border.all(color: Colors.red, width: 4),
        ),
        child: Text(
          TextUtils.login,
          style: TextStyleUtils.textStyleNunitoS20W600White,
        ),
      ),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TextUtils.accountHint,
          style: TextStyleUtils.textStyleNunitoS16W400Black,
        ),
        InkWell(
          onTap: () {
            AutoRouter.of(context).push(RegisterRoute())
                .then((value) => context.read<LoginBloc>().add(LoginEventInit()));
          },
          child: Text(
            TextUtils.register,
            style: TextStyleUtils.textStyleNunitoS16W400Primary,
          ),
        ),
      ],
    );
  }

  Widget _errorText(String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        message,
        style: TextStyleUtils.textStyleNunitoS16W400Red,
      ),
    );
  }
}

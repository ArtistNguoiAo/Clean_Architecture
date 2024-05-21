import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:risky_coin/presentation/common/text_field_common.dart';
import 'package:risky_coin/presentation/screen/register_screen/bloc/register_bloc.dart';
import 'package:risky_coin/presentation/utils/color_utils.dart';
import 'package:risky_coin/presentation/utils/dialog_helper.dart';
import 'package:risky_coin/presentation/utils/text_style_utils.dart';
import 'package:risky_coin/presentation/utils/text_utils.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc()..add(RegisterEventInit()),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if(state is RegisterStateLoaded) {
            emailController.text = '';
            passwordController.text = '';
            confirmPasswordController.text = '';
          }
          if(state is RegisterStateRegisterSuccess) {
            DialogHelper.hideLoadingDialog(context);
            AutoRouter.of(context).maybePop();
          }
          if(state is RegisterStateLoading) {
            DialogHelper.showLoadingDialog(context);
          }
          if(state is RegisterStateError) {
            DialogHelper.hideLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: _appBar(context),
            body: _body(context),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          AutoRouter.of(context).maybePop();
        },
        icon: const FaIcon(
          FontAwesomeIcons.chevronLeft,
        ),
      ),
    );
  }
  Widget _body(BuildContext context) {
    RegisterState state = context.select((RegisterBloc bloc) => bloc.state);
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
                  _confirmPasswordTextField(),
                  _sizeBoxH16(),
                  if(state is RegisterStateError) ...[
                    _errorText(state.message),
                  ],
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

  Widget _confirmPasswordTextField() {
    return TextFieldCommon(
      hintText: TextUtils.confirmPassword,
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
      controller: confirmPasswordController,
    );
  }

  Widget _sizeBoxH16() {
    return const SizedBox(height: 16);
  }

  Widget _buttonRegister(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<RegisterBloc>().add(
          RegisterEventRegister(
            email: emailController.text,
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text,
          ),
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
          TextUtils.register,
          style: TextStyleUtils.textStyleNunitoS20W600White,
        ),
      ),
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

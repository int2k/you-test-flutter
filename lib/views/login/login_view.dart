import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youappflutter/bloc/auth/auth_bloc.dart';
import 'package:youappflutter/components/appbar.dart';
import 'package:youappflutter/components/button.dart';
import 'package:youappflutter/components/custom_text.dart';
import 'package:youappflutter/constants/icon_enums.dart';
import 'package:youappflutter/constants/string_constant.dart';
import 'package:youappflutter/extensions/context_extensions.dart';
import 'package:youappflutter/extensions/image_extensions.dart';
import 'package:youappflutter/extensions/num_extensions.dart';
import 'package:youappflutter/components/form_field_text.dart';
import 'package:youappflutter/utils/validate_operations.dart';

import '../../utils/typedefs.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.transparent,
      body:Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          gradient: RadialGradient(
            center: Alignment(0.58, 0.83),
            radius: 0.35,
            colors: [Color(0xFF1F4247), Color(0xFF0D1C22), Color(0xFF09141A)],
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child:
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidth(0.05),
            ),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _EmailFormField(emailController: emailController),
                    _PasswordFormField(passwordController: passwordController),
                    _LoginButton(
                      onTap: () {
                        if (validate != null && validate == true) {
                          context.read<AuthBloc>().add(LoginRequested(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          ));
                        }
                      },
                    ),
                    _OpenRegisterButton(
                      onTap: () {
                        context.read<AuthBloc>().add(RegisterStarted());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoAndTitleWidget extends StatelessWidget {
  const _LogoAndTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicHeight(0.06),
      ),
      child: Column(
        children: [
          Image.asset(
            IconEnums.appLogo.iconName.toPng,
            height: context.dynamicHeight(0.2),
          ),
          20.ph,
          CustomText(
            StringConstants.loginTitle,
            textStyle: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _EmailFormField extends StatelessWidget {
  const _EmailFormField({
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: emailController,
      title: StringConstants.emailTitle,
      hintText: StringConstants.emailHint,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) => ValidateOperations.emailValidation(value),
    );
  }
}

class _PasswordFormField extends StatelessWidget {
  const _PasswordFormField({
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: passwordController,
      title: StringConstants.passwordTitle,
      hintText: StringConstants.passwordHint,
      isPassword: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: StringConstants.loginButtonText,
      onTap: onTap,
    );
  }
}

class _OpenRegisterButton extends StatelessWidget {
  const _OpenRegisterButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: StringConstants.registerButtonText,
      onTap: onTap,
    );
  }
}


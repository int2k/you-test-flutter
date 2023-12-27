import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youappflutter/bloc/auth/auth_bloc.dart';
import 'package:youappflutter/components/appbar.dart';
import 'package:youappflutter/components/button.dart';
import 'package:youappflutter/components/custom_text.dart';
import 'package:youappflutter/constants/string_constant.dart';
import 'package:youappflutter/extensions/context_extensions.dart';
import 'package:youappflutter/components/form_field_text.dart';
import 'package:youappflutter/utils/validate_operations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          gradient: const RadialGradient(
            center: Alignment(0.58, 0.83),
            radius: 0.35,
            colors: [Color(0xFF1F4247), Color(0xFF0D1C22), Color(0xFF09141A)],
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.dynamicWidth(0.05),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ElevatedButton.icon(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Back'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Register',
                            textAlign: TextAlign.left,
                            // overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _EmailFormField(emailController: emailController),
                              _UsernameFormField(
                                  usernameController: usernameController),
                              _PasswordFormField(
                                  passwordController: passwordController),
                              _ConfirmPasswordFormField(
                                  passwordController:
                                      confirmPasswordController),
                              _RegisterButton(
                                onTap: () {
                                  if (validate != null && validate == true) {
                                    context
                                        .read<AuthBloc>()
                                        .add(RegisterRequested(
                                          emailController.text.trim(),
                                          usernameController.text.trim(),
                                          passwordController.text.trim(),
                                        ));
                                  }
                                },
                              ),
                              _LoginTextLink(
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(LoginStarted());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),

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
          // Image.asset(
          //   IconEnums.appLogo.iconName.toPng,
          //   height: context.dynamicHeight(0.2),
          // ),
          // 30.ph,
          CustomText(
            StringConstants.registerTitle,
            textStyle: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _UsernameFormField extends StatelessWidget {
  const _UsernameFormField({
    required this.usernameController,
  });

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: usernameController,
      title: StringConstants.usernameTitle,
      hintText: StringConstants.usernameHint,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        usernameController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
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

class _ConfirmPasswordFormField extends StatelessWidget {
  const _ConfirmPasswordFormField({
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: passwordController,
      title: StringConstants.confirmPasswordTitle,
      hintText: StringConstants.passwordHint,
      isPassword: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: StringConstants.registerButtonText,
      onTap: onTap,
    );
  }
}


class _LoginTextLink extends StatelessWidget {
  const _LoginTextLink({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Have an account? ',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: 'Login here',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Color(0xFF93773E),
                decorationColor: Color(0xFF93773E),
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap),
        ],
      ),
    );
  }
}

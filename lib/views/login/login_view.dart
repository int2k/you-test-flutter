import 'package:flutter/gestures.dart';
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
            // appBar: CustomAppBar(),
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
                                  onPressed: () => {

                                    if (Navigator.of(context).canPop())
                                      Navigator.of(context).maybePop()
                                  },
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
                              'Login',
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
                                _EmailFormField(
                                    emailController: emailController),
                                SizedBox(
                                  height: 1, // <-- SEE HERE
                                ),
                                _PasswordFormField(
                                    passwordController: passwordController),
                                _LoginButton(
                                  onTap: () {
                                    if (validate != null && validate == true) {
                                      context
                                          .read<AuthBloc>()
                                          .add(LoginRequested(
                                            emailController.text.trim(),
                                            passwordController.text.trim(),
                                          ));
                                    }
                                  },
                                ),

                                _RegisterTextLink(
                                  onTap: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(RegisterStarted());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )),
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
        vertical: context.dynamicHeight(0.05),
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
      // title: StringConstants.emailTitle,
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
      // title: StringConstants.passwordTitle,
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

class _LoginShadowButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LoginShadowButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: Stack(children: [
          Positioned(
            left: 0,
            top: 60,
            child: Container(
              height: 48,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.95, -0.31),
                  end: Alignment(-0.95, 0.31),
                  colors: [Color(0xFF62CDCB), Color(0xFF4599DB)],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          Container(
              height: 48,
              child: Stack(
                children: [
                  Container(
                    height: 48,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.95, -0.31),
                        end: Alignment(-0.95, 0.31),
                        colors: [Color(0xFF62CDCB), Color(0xFF4599DB)],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: onTap,
                      child: CustomText('Login',
                          textStyle: context.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                ],
              ))
        ]));
  }
}

class _RegisterTextLink extends StatelessWidget {
  const _RegisterTextLink({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'No account? ',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
              text: 'Register here',
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

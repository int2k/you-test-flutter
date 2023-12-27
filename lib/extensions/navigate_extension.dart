

import 'package:flutter/widgets.dart';
import 'package:youappflutter/constants/auth_enums.dart';
import 'package:youappflutter/views/home/home_view.dart';
import 'package:youappflutter/views/login/login_view.dart';
import 'package:youappflutter/views/register/register_view.dart';

extension NavigateExtension on AuthStatus {
  Widget get firstView {
    switch (this) {
      case AuthStatus.authenticated:
        return const HomeView();
      case AuthStatus.guest:
        return const LoginView();
      case AuthStatus.register:
        return const RegisterView();
      case AuthStatus.unknown:

      /// MARK: It can be IntroView.
        break;
    }
    return const LoginView();
  }
}
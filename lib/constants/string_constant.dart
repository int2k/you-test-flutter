import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  static const String appName = 'Youapp Test';

  /// for Login view
  ///
  static const String backTitle = "Back";
  static const String loginTitle = "You can log in with your information.";
  static const String registerTitle = "You can register with your information.";
  static const String loginButtonText = "LOGIN";
  static const String registerButtonText = "REGISTER";
  static const String emailTitle = "Email";
  static const String usernameTitle = "Username";
  static const String passwordTitle = "Password";
  static const String confirmPasswordTitle = "Confirm Password";
  static const String emailHint = 'example@gmail.com';
  static const String usernameHint = '';
  static const String passwordHint = '···········';

  /// for Home view
  static const String homePage = 'Home Page';

  /// for validators
  static const String requiredField = "Required field";
  static const String makeSureCorrectMail =
      "Please make sure you enter the correct email.";
}

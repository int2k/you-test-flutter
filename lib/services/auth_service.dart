import 'dart:io';

import 'package:youappflutter/constants/network_enums.dart';
import 'package:youappflutter/models/auth_model.dart';
import 'package:youappflutter/models/login_model.dart';
import 'package:youappflutter/models/register_model.dart';
import 'package:youappflutter/models/register_response_model.dart';
import 'package:youappflutter/services/interface_auth_service.dart';

class AuthService extends IAuthService {
  AuthService(super.dioManager);

  @override
  Future<String?> login({
    required String email,
    required String username,
    required String password,
  }) async {
    var dataModel = LoginModel(
      email: email,
      username: username,
      password: password,
    ).toJson();
    try {
      var response = await dioManager.dio.post(
        NetworkEnums.login.path,
        data: dataModel,
      );

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return AuthModel.fromJson(response.data).token;
      } else {
        return throw Exception();
      }
    } on Exception {
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<String?> register({
    required String email,
    required String username,
    required String password,
  }) async {
    var dataModel = RegisterModel(
      email: email,
      username: username,
      password: password,
    ).toJson();
    try {
      var response = await dioManager.dio.post(
        NetworkEnums.register.path,
        data: dataModel,
      );

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return RegisterResponseModel.fromJson(response.data).message;
      } else {
        return throw Exception();
      }
    } on Exception {
      rethrow;
    } catch (err) {
      rethrow;
    }
  }
}

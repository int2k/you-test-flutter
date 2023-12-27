import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:youappflutter/constants/auth_enums.dart';
import 'package:youappflutter/init/cache/auth_cache_manager.dart';
import 'package:youappflutter/services/interface_auth_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService authService;
  final AuthCacheManager authCacheManager;

  AuthBloc(this.authService, this.authCacheManager)
      : super(const AuthState.unknown()) {
    on<AppStarted>((event, emit) async {
      try {
        if (await authCacheManager.isLoggedIn()) {
          await authCacheManager.updateTokenFromStorage();
          emit(const AuthState.authenticated());
        } else {
          emit((await authCacheManager.isFirstEntry())
              ? const AuthState.firstEntry()
              : const AuthState.guest());
        }
      } on SocketException {
        emit(const AuthState.error(error: AuthError.hostUnreachable));
      } catch (e) {
        log(e.toString());
        emit(const AuthState.error());
      }
    });

    on<LoginRequested>(
      (event, emit) async {
        var isEmail = EmailValidator.validate(event.email);
        var email = event.email;
        var username = '';
        if (!isEmail) {
          email = '';
          username = event.email;
        }
        final String? response = await authService.login(
            email: email, username: username, password: event.password);
        if (response != null) {
          await authCacheManager.updateToken(response);
          await authCacheManager.updateLoggedIn(true);
          emit(const AuthState.authenticated());
        } else {
          add(LogoutRequested());
          emit(const AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );

    on<LogoutRequested>((event, emit) async {
      try {
        await authCacheManager.signOut();
        emit(const AuthState.guest());
      } catch (_) {}
    });

    on<RegisterStarted>((event, emit) async {
      try {
        emit(const AuthState.register());
      } catch (e) {
        log(e.toString());
        emit(const AuthState.error());
      }
    });

    on<RegisterRequested>(
      (event, emit) async {
        final String? response = await authService.register(
            email: event.email, username: event.username, password: event.password);
        if (response != null) {
          emit(const AuthState.guest());
        } else {
          add(const RegisterFailed('Unknown'));
          emit(const AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );
  }
}

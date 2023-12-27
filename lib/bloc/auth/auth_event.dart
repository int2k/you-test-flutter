part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}

class RegisterStarted extends AuthEvent {}

class RegisterRequested extends AuthEvent {
  final String email;
  final String username;
  final String password;

  const RegisterRequested(this.email, this.username, this.password);

  @override
  List<Object?> get props => [email, username, password];
}

class RegisterFailed extends AuthEvent {
  final String message;

  const RegisterFailed(this.message);

  @override
  List<Object?> get props => [message];

}
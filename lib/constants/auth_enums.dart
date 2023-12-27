enum AuthStatus { unknown, authenticated, guest, register }

enum AuthError {
  hostUnreachable,
  unknown,
  wrongEmailOrPassword,
}

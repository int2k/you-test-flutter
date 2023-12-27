class AuthModel {
  String? token;

  AuthModel({
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['access_token'] as String?,
    );
  }
}
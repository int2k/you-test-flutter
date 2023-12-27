class LoginModel {
  String? email;
  String? password;
  String? username;

  LoginModel({
    this.email,
    this.username,
    this.password,

  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
    };
  }
}
class RegisterModel {
  String? email;
  String? password;
  String? username;

  RegisterModel({
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
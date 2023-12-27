class RegisterResponseModel {
  String? message;

  RegisterResponseModel({
    this.message,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message'] as String?,
    );
  }
}
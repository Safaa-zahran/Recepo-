class RegisterResponse {
  String? token;

  RegisterResponse({this.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {

      'token': token,
    };
  }

}
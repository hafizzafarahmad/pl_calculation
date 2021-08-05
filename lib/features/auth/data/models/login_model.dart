class LoginModel {
  int? code;
  String? status;
  String? message;
  LoginDataModel? data;

  LoginModel({this.code, this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new LoginDataModel.fromJson(json['data']) : null;
  }

}

class LoginDataModel {
  String? token;

  LoginDataModel({this.token});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
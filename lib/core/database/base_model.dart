class BaseModel {
  int? code;
  String? message;

  BaseModel({this.code, this.message});

  BaseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
}
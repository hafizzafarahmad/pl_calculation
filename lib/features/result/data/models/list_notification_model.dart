

class ResultModel {
  int? code;
  String? status;
  String? messages;

  ResultModel({this.code, this.status, this.messages });

  ResultModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    messages = json['messages'];
  }
}
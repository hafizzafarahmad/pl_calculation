

class ListResultModel {
  int? code;
  String? messages;
  String? status;

  ListResultModel({this.code, this.messages, this.status});

  ListResultModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    messages = json['messages'];
    status = json['status'];
  }
}


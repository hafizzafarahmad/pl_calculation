
import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';

@HiveType(typeId: TYPE_RESULT)
class ResultEntity {
  @HiveField(0)
  String? resultH27;
  @HiveField(1)
  String? resultH28;
  @HiveField(2)
  String? resultH30;
  @HiveField(3)
  String? resultH31;
  @HiveField(4)
  String? resultH32;

  ResultEntity(
      {this.resultH27  = "-",
        this.resultH28  = "-",
        this.resultH30  = "-",
        this.resultH31  = "-",
        this.resultH32  = "-"});

  ResultEntity.fromJson(Map<String, dynamic> json) {
    resultH27 = json['result_h27'];
    resultH28 = json['result_h28'];
    resultH30 = json['result_h30'];
    resultH31 = json['result_h31'];
    resultH32 = json['result_h32'];
  }
}

import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
part 'result_entity.g.dart';

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
      this.resultH27,
      this.resultH28,
      this.resultH30,
      this.resultH31,
      this.resultH32);

  ResultEntity.fromJson(Map<String, dynamic> json) {
    resultH27 = json['result_h27'] is num ? json['result_h27'].toStringAsFixed(3) : "-";
    resultH28 = json['result_h28'] is num ? json['result_h28'].toStringAsFixed(3) : "-";
    resultH30 = json['result_h30'] is num ? json['result_h30'].toStringAsFixed(3) : "-";
    resultH31 = json['result_h31'] is num ? json['result_h31'].toStringAsFixed(3) : "-";
    resultH32 = json['result_h32'] is num ? json['result_h32'].toStringAsFixed(3) : "-";
  }
}

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
  @HiveField(5)
  String? resultF67;
  @HiveField(6)
  String? resultF68;
  @HiveField(7)
  String? resultF69;
  @HiveField(8)
  String? resultF71;
  @HiveField(9)
  String? resultF72;
  @HiveField(10)
  String? resultF73;
  @HiveField(11)
  String? resultH62;
  @HiveField(12)
  String? resultH63;
  @HiveField(13)
  String? resultH65;
  @HiveField(14)
  String? resultH66;
  @HiveField(15)
  String? resultJ77;
  @HiveField(16)
  String? resultJ78;
  @HiveField(17)
  String? resultJ79;
  @HiveField(18)
  String? resultJ81;
  @HiveField(19)
  String? resultJ82;
  @HiveField(20)
  String? resultJ83;

  ResultEntity(
      {this.resultH27,
        this.resultH28,
        this.resultH30,
        this.resultH31,
        this.resultH32,
        this.resultF67,
        this.resultF68,
        this.resultF69,
        this.resultF71,
        this.resultF72,
        this.resultF73,
        this.resultH62,
        this.resultH63,
        this.resultH65,
        this.resultH66,
        this.resultJ77,
        this.resultJ78,
        this.resultJ79,
        this.resultJ81,
        this.resultJ82,
        this.resultJ83});

  ResultEntity.fromJson(Map<String, dynamic> json) {
    resultH27 = json['result_h27']?? "-";
    resultH28 = json['result_h28']??"-";
    resultH30 = json['result_h30']?? "-";
    resultH31 = json['result_h31']?? "-";
    resultH32 = json['result_h32']?? "-";
    resultF67 = json['result_f67']?? "-";
    resultF68 = json['result_f68']?? "-";
    resultF69 = json['result_f69']?? "-";
    resultF71 = json['result_f71']?? "-";
    resultF72 = json['result_f72']?? "-";
    resultF73 = json['result_f73']?? "-";
    resultH62 = json['result_h62']?? "-";
    resultH63 = json['result_h63']?? "-";
    resultH65 = json['result_h65']?? "-";
    resultH66 = json['result_h66']??"-";
    resultJ77 = json['result_j77']??"-";
    resultJ78 = json['result_j78']??"-";
    resultJ79 = json['result_j79']??"-";
    resultJ81 = json['result_j81']?? "-";
    resultJ82 = json['result_j82']?? "-";
    resultJ83 = json['result_j83']?? "-";
  }

  // ResultEntity.fromJson(Map<String, dynamic> json) {
  //   resultH27 = json['result_h27'] is num ? json['result_h27'].toString() : "-";
  //   resultH28 = json['result_h28'] is num ? json['result_h28'].toString() : "-";
  //   resultH30 = json['result_h30'] is num ? json['result_h30'].toString() : "-";
  //   resultH31 = json['result_h31'] is num ? json['result_h31'].toString() : "-";
  //   resultH32 = json['result_h32'] is num ? json['result_h32'].toString() : "-";
  //   resultF67 = json['result_f67'] is num ? json['result_f67'].toString() : "-";
  //   resultF68 = json['result_f68'] is num ? json['result_f68'].toString() : "-";
  //   resultF69 = json['result_f69'] is num ? json['result_f69'].toString() : "-";
  //   resultF71 = json['result_f71'] is num ? json['result_f71'].toString() : "-";
  //   resultF72 = json['result_f72']is num ? json['result_f72'].toString() : "-";
  //   resultF73 = json['result_f73']is num ? json['result_f73'].toString() : "-";
  //   resultH62 = json['result_h62']is num ? json['result_h62'].toString() : "-";
  //   resultH63 = json['result_h63']is num ? json['result_h63'].toString() : "-";
  //   resultH65 = json['result_h65']is num ? json['result_h65'].toString() : "-";
  //   resultH66 = json['result_h66']is num ? json['result_h66'].toString() : "-";
  //   resultJ77 = json['result_j77']is num ? json['result_j77'].toString() : "-";
  //   resultJ78 = json['result_j78']is num ? json['result_j78'].toString() : "-";
  //   resultJ79 = json['result_j79']is num ? json['result_j79'].toString() : "-";
  //   resultJ81 = json['result_j81']is num ? json['result_j81'].toString() : "-";
  //   resultJ82 = json['result_j82']is num ? json['result_j82'].toString() : "-";
  //   resultJ83 = json['result_j83']is num ? json['result_j83'].toString() : "-";
  // }
}
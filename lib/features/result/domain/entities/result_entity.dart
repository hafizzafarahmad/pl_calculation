
import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
part 'result_entity.g.dart';

@HiveType(typeId: TYPE_RESULT)
class ResultEntity {
  @HiveField(0)
  String? h28;
  @HiveField(1)
  String? h29;
  @HiveField(2)
  String? h31;
  @HiveField(3)
  String? h32;
  @HiveField(4)
  String? h33;
  @HiveField(5)
  String? h62;
  @HiveField(6)
  String? h63;
  @HiveField(7)
  String? h64;
  @HiveField(8)
  String? h66;
  @HiveField(9)
  String? f67;
  @HiveField(10)
  String? f68;
  @HiveField(11)
  String? f69;
  @HiveField(12)
  String? f72;
  @HiveField(13)
  String? f73;
  @HiveField(14)
  String? f74;
  @HiveField(15)
  String? j31;
  @HiveField(16)
  String? j32;
  @HiveField(17)
  String? j33;
  @HiveField(18)
  String? j71;
  @HiveField(19)
  String? j72;
  @HiveField(20)
  String? j73;
  @HiveField(21)
  String? j74;
  @HiveField(22)
  String? j75;
  @HiveField(23)
  String? j76;
  @HiveField(24)
  String? j77;
  @HiveField(25)
  String? j78;
  @HiveField(26)
  String? j79;
  @HiveField(27)
  String? j82;
  @HiveField(28)
  String? j83;
  @HiveField(29)
  String? j84;
  @HiveField(30)
  String? d82;
  @HiveField(31)
  String? d83;
  @HiveField(32)
  String? d84;
  @HiveField(33)
  String? j80;
  @HiveField(34)
  String? h67;


  ResultEntity(
      {this.h28,
        this.h67,
        this.h29,
        this.j80,
        this.h31,
        this.h32,
        this.h33,
        this.h62,
        this.h63,
        this.h64,
        this.h66,
        this.f67,
        this.f68,
        this.f69,
        this.f72,
        this.f73,
        this.f74,
        this.j31,
        this.j32,
        this.j33,
        this.j71,
        this.j72,
        this.j73,
        this.j74,
        this.j75,
        this.j76,
        this.j77,
        this.j78,
        this.j79,
        this.j82,
        this.j83,
        this.j84,
        this.d82,
        this.d83,
        this.d84});

  ResultEntity.fromJson(Map<String, dynamic> json) {
    h28 = json['H28']?? "-";
    h29 = json['H29']?? "-";
    h31 = json['H31']?? "-";
    h32 = json['H32']?? "-";
    h33 = json['H33']?? "-";
    h62 = json['H62']?? "-";
    h63 = json['H63']?? "-";
    h64 = json['H64']?? "-";
    h66 = json['H66']?? "-";
    f67 = json['F67']?? "-";
    f68 = json['F68']?? "-";
    f69 = json['F69']?? "-";
    f72 = json['F72']?? "-";
    f73 = json['F73']?? "-";
    f74 = json['F74']?? "-";
    j31 = json['J31']?? "-";
    j32 = json['J32']?? "-";
    j33 = json['J33']?? "-";
    j71 = json['J71']?? "-";
    j72 = json['J72']?? "-";
    j73 = json['J73']?? "-";
    j74 = json['J74']?? "-";
    j75 = json['J75']?? "-";
    j76 = json['J76']?? "-";
    j77 = json['J77']?? "-";
    j78 = json['J78']?? "-";
    j79 = json['J79']?? "-";
    j82 = json['J82']?? "-";
    j83 = json['J83']?? "-";
    j84 = json['J84']?? "-";
    d82 = json['D82']?? "-";
    d83 = json['D83']?? "-";
    d84 = json['D84']?? "-";
    j80 = json['D80']?? "-";
    h67 = json['H67']?? "-";
  }
}



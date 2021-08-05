
import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';
part 'list_result_entity.g.dart';

@HiveType(typeId: TYPE_MENU_LIST_RESULT)
class ListResultEntity {
  @HiveField(0)
  ResultEntity? resultEntity;
  @HiveField(1)
  CalculateEntity? calculateEntity;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? createdAt;

  ListResultEntity(
      {this.resultEntity, this.calculateEntity, this.name, this.createdAt});

}
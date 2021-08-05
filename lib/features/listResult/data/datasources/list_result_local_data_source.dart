

import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';

abstract class ListResultLocalDataSource{
  Future<List<ListResultEntity>> getCacheListResult();
}

class ListResultLocalDataSourceImpl implements ListResultLocalDataSource{

  @override
  Future<List<ListResultEntity>> getCacheListResult()  async {
    var box = await Hive.openBox(BOX_MENU_LIST_RESULT);
    if(box.isEmpty){
      throw CacheException();
    }else{
      List<ListResultEntity> _list = [];
      for(int i=0; i < box.length; i++){
        _list.add(box.getAt(i));
      }
      return _list;
    }
  }

}

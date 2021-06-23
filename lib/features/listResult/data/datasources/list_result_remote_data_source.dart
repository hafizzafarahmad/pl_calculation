import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/error/exception.dart';
import 'package:pl_calculation/features/listResult/data/models/list_pengajuan_model.dart';

abstract class ListResultRemoteDataSource{
  Future<ListResultModel> getListResult();
}

class ListResultRemoteDataSourceImpl implements ListResultRemoteDataSource{

  ListResultRemoteDataSourceImpl();

  @override
  Future<ListResultModel> getListResult() async {
    var boxMenuReult = await Hive.openBox(BOX_MENU_LIST_RESULT);
    if(boxMenuReult.isEmpty){
      throw CacheException();
    }else{
      return boxMenuReult.getAt(0);
    }
  }

}
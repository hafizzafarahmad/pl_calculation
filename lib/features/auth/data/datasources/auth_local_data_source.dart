import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class AuthLocalDataSource {

}

class AuthLocalDataSourceImpl implements AuthLocalDataSource{
  final SharedPreferences? sharedPreferences;

  AuthLocalDataSourceImpl({this.sharedPreferences});

  
}
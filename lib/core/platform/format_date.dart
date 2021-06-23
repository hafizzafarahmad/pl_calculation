
import 'package:intl/intl.dart';

//Dari Formatted data to plain date (10 Januari 2020)
setPlainDate(String date){
  String formatted;
  try{
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime dateTime = dateFormat.parse(date);
    var formatter = new DateFormat('dd MMMM yyyy');
    formatted = formatter.format(dateTime);
  }on FormatException catch(e){
    formatted = '-';
  }
  return formatted;
}

//Dari Formatted Date (2020-10-10 00:00:00) to (2020-10-10)
setFormattedDate(String date){
  String formatted;
  try{
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime dateTime = dateFormat.parse(date);
    var formatter = new DateFormat('yyyy-MM-dd');
    formatted = formatter.format(dateTime);

  }on FormatException catch(e){
    formatted = '';
  }
  return formatted;
}
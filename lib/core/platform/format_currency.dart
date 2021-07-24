
import 'package:intl/intl.dart';

//Format Currency
formattedCurrency(String nominal){
  String result;
  try{
    final formatMoney = new NumberFormat("#,##0.00", "en_US");
    result = formatMoney.format(double.parse(nominal));
  }on FormatException catch(e){
    result = '-';
  }
  return result;
}
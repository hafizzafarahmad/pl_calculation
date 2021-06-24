
import 'package:intl/intl.dart';

//Format Currency
formattedCurrency(String nominal){
  String result;
  try{
    final formatMoney = new NumberFormat("#,##0", "en_US");
    result = formatMoney.format(int.parse(nominal)).replaceAll(',', '.');
  }on FormatException catch(e){
    result = '-';
  }
  return result;
}
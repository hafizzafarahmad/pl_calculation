
import 'package:intl/intl.dart';

//Format Currency
formattedCurrency(String nominal){
  try{
    if(nominal.split(".").first != "0"){
      final formatMoney = new NumberFormat("#,##0", "en_US");
      // final formatMoney = new NumberFormat.decimalPattern();
      String result = formatMoney.format(double.parse(nominal));
      return "$result.";
    } else {
      return "0.";
    }


  }on FormatException catch(e){
    return "";
  }
}
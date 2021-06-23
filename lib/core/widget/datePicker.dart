import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/platform/colors.dart';

Future<String?> datePicker(BuildContext context, initial)async{
  int yearInit = 2000, monthInit = 11, dayInit = 11;
  if(initial != null){
    yearInit = int.parse(initial.toString().split('-')[0]);
    monthInit = int.parse(initial.toString().split('-')[1]);
    dayInit = int.parse(initial.toString().split('-')[2]);
  }

  final pickedDate = await showDatePicker(
    context: context,
    initialDate: (initial == null) ? DateTime.now() : DateTime(yearInit, monthInit, dayInit),
    firstDate: new DateTime(new DateTime.now().year - 100),
    lastDate: new DateTime(new DateTime.now().year + 2),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Pigment.fromString(PRIMARY_COLOR)),
          ),
          child: child!,
        );
      }
  );
  if(pickedDate != null){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(pickedDate.toString());
    var formatter = new DateFormat('yyyy-MM-dd');
    var tanggal = formatter.format(dateTime);
    print(tanggal);

    return tanggal;
  }else{
    return null;
  }


}
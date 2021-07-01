
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pigment/pigment.dart';
import 'package:shimmer/shimmer.dart';

import 'colors.dart';


//Size Menyesuaikan Ukuran Lebar Layar
autoSizedWidth(BuildContext context, size){
  var sized = MediaQuery.of(context).size.width * size;
  return sized;
}

//Size Menyesuaikan Ukuran Tinggi Layar
autoSizedHeight(BuildContext context, size){
  var sized = MediaQuery.of(context).size.height * size;
  return sized;
}

//PopUp Message
alertToast(String message){
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Pigment.fromString(PRIMARY_COLOR),
      textColor: Colors.white,
      fontSize: 16.0);
}
redAlertToast(String message){
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

//HideKeyboard
hideKeyboard(BuildContext context){
  FocusScope.of(context).requestFocus(new FocusNode());
}

Widget shimmerLine({double? width, double height = 15}){
  return Shimmer.fromColors(
      baseColor: Pigment.fromString('#ededed'),
      highlightColor: Pigment.fromString('#f5f5f5'),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(3.0)
        ),
      )
  );
}
import 'package:flutter/material.dart';

InputDecoration inputStyle(BuildContext context, {String? suffixText, String hint = ""}){
  return InputDecoration(
    suffixText: suffixText,
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    hintText: hint,
  );
}
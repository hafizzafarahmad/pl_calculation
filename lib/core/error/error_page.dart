
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';

class ErrorPage extends StatelessWidget {
  final String messages;
  final GestureTapCallback? onTap;

  const ErrorPage({Key? key, this.messages = "Connection Error", this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: autoSizedWidth(context, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_outlined, size: 150, color: Colors.grey,),
            SizedBox(height: 5,),
            Text('Connection Error', style: TextStyle(
              color: Colors.grey,
              fontSize: 16,

            )
            ),

            GestureDetector(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, size: 20, color: Colors.black,),
                  SizedBox(width: 5,),
                  Text(
                    'Try Again',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'PoppinsMedium'
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}



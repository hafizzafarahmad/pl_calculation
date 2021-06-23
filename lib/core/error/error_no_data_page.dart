
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';

class ErrorNoDataPage extends StatelessWidget {
  final String messages;
  final GestureTapCallback? onTap;

  const ErrorNoDataPage({Key? key, this.messages = "Tidak ada data", this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: autoSizedWidth(context, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/information/no-data.png', height: 200, width: 200,),
            Text('Opps!,', style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontFamily: 'PoppinsMedium',
              fontWeight: FontWeight.bold
            )
            ),
            SizedBox(height: 5,),
            Text('$messages', style: TextStyle(
              color: Colors.grey,
              fontSize: 16,

            )
            ),
            SizedBox(height: 20,),
            Card(
              color: Colors.white,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: onTap,
                child: Container(
                    width: autoSizedWidth(context, 0.4),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Pigment.fromString(PRIMARY_COLOR))
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh, size: 20, color: Pigment.fromString(PRIMARY_COLOR),),
                          SizedBox(width: 10,),
                          Text(
                            'Coba Lagi',
                            style: TextStyle(
                              fontSize: 15,
                              color: Pigment.fromString(PRIMARY_COLOR),
                              fontFamily: 'PoppinsMedium'
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    ,)
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}



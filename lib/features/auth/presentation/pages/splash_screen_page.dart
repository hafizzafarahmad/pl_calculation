import 'package:flutter/material.dart';
import 'package:pl_calculation/features/listResult/presentation/pages/list_result_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPage createState() => _SplashScreenPage();
}

class _SplashScreenPage extends State<SplashScreenPage> {

  _onStart() async {
    // await Future.delayed(Duration(seconds: 3));
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListResultPage()));
  }

  @override
  void initState() {
    _onStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Center(
            child:  Image.asset(
              'assets/arabica-1227.png',
              fit: BoxFit.cover,
              width: 200,
            ),
          )
        ],
      ),
    );
  }

}


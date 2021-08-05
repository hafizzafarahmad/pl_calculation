import 'package:flutter/material.dart';
import 'isi_data_page.dart';



class IndexIsiCalculate extends StatefulWidget {

  const IndexIsiCalculate({Key? key}) : super(key: key);

  @override
  _IndexIsiCalculate createState() => _IndexIsiCalculate();
}

class _IndexIsiCalculate extends State<IndexIsiCalculate> {

  //PAGE CONTROLLER
  PageController _controller = PageController(initialPage: 0, viewportFraction: 1.0);
  _gotoPage(int position) {
    _controller.animateToPage(
      position,
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: new NeverScrollableScrollPhysics(),
      children: <Widget>[
        IsiDataPage(),
      ],
    );
  }

}
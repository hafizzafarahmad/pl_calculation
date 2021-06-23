
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/features/calculate/presentation/pages/index_isi_calculate.dart';
import 'package:pl_calculation/features/listResult/data/models/list_pengajuan_model.dart';

class ListResultPage extends StatefulWidget {
  @override
  _ListResultPage createState() => _ListResultPage();
}

class _ListResultPage extends State<ListResultPage> {

  ListResultModel? listResultModel;

  _onRefresh() async {
    // context.read<ListPengajuanBloc>().add(ListPengajuanInitializedEvent(context));
  }

  @override
  void initState() {
    // context.read<ProfileBloc>().add(GetProfileEvent());
    // context.read<ListPengajuanBloc>().add(ListPengajuanInitializedEvent(context));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Result', style: TextStyle(color: Colors.black, fontFamily: 'PoppinsMedium'),),
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return _onRefresh();
        },
        child: ScrollConfiguration(
          behavior: MyScrollBehavior(),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),

          ),
        ),
      ),



      floatingActionButton: Container(
        child: Card(
          color: Pigment.fromString(PRIMARY_COLOR),
          elevation: 1.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(50.0),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => IndexIsiCalculate()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top:13, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(LineAwesomeIcons.plus, color: Colors.white, size: 30,),
            ),
          ),
        ),
      ),
    );
  }

}
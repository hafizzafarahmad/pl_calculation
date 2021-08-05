
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/error/error_no_data_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/core/error/error_page.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/core/widget/dialogToConfirm.dart';
import 'package:pl_calculation/core/widget/list_loading.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_event.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_bloc.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_event.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_state.dart';
import 'package:pl_calculation/features/result/presentation/pages/index_isi_calculate.dart';

class ListResultPage extends StatefulWidget {
  @override
  _ListResultPage createState() => _ListResultPage();
}

class _ListResultPage extends State<ListResultPage> {

   _onRefresh() async {
    context.read<ListResultBloc>().add(GetListResultEvent());
  }

  @override
  void initState() {
    _onRefresh();
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
        title: Text('Engine Calculation', style: TextStyle(color: Colors.black, fontFamily: 'PoppinsMedium'),),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: <Widget>[
                    Icon(LineAwesomeIcons.alternate_sign_out, size: 18, color: Colors.black, ),
                    SizedBox(width: 5,),
                    Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            icon: Icon(LineAwesomeIcons.vertical_ellipsis, size: 18, color: Colors.black,),
            offset: Offset(0, 0),
            onSelected: (value){
              if(value == 0){
                dialogToConfirm(context, message: 'Logout Account?', onTap: (){
                  context.read<AuthBloc>().add(LogoutUserEvent(context));
                });
              }else{

              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return _onRefresh();
        },
        child: ScrollConfiguration(
          behavior: MyScrollBehavior(),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child:
            BlocBuilder<ListResultBloc, ListResultState>(
              builder: (context, state){
                print(state);
                if(state is LoadingListResultState){
                  return listLoading(context);
                } else if (state is ListResultRetrievedState){
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100, top: 3),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      itemCount: state.listResult!.length,
                      itemBuilder: (context, i){
                        return Container();
                      }
                  );
                } else if (state is ErrorDataNullListResultState){
                  return Container(
                    width: autoSizedWidth(context, 1),
                    height: autoSizedHeight(context, 0.75),
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: ErrorNoDataPage(messages: 'No Data Found', onTap: () {

                    },)
                    ,);
                } else if (state is ErrorListResultState) {
                  return Container(
                    width: autoSizedWidth(context, 1),
                    height: autoSizedHeight(context, 0.75),
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: ErrorPage(messages: 'Something Wrong', onTap: () {
                      _onRefresh();
                    },)
                    ,);
                } else {
                  return Container();
                }
              },
            )
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
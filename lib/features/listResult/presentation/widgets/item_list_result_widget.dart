
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pl_calculation/core/platform/format_date.dart';
import 'package:pl_calculation/core/widget/dialogToConfirm.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_bloc.dart';
import 'package:pl_calculation/features/listResult/presentation/bloc/list_result_event.dart';
import 'package:pl_calculation/features/listResult/presentation/pages/detail_result_page.dart';

class ItemListResultWidget extends StatelessWidget{
  final int? index;
  final ListResultEntity? listResultEntity;

  const ItemListResultWidget({this.index, this.listResultEntity}) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailResultPage(listResultEntity: listResultEntity,)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 0.0)
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 15, color: Colors.blue,),
                        SizedBox(width: 10,),
                        Text(
                          '${setPlainDate(listResultEntity!.createdAt!)}',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "PoppinsMedium",
                              color: Colors.black
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '${listResultEntity!.name!}',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "PoppinsSemiBold",
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: 3,),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Row(
                        children: <Widget>[
                          Icon(LineAwesomeIcons.info_circle, size: 18, color: Colors.black, ),
                          SizedBox(width: 5,),
                          Text(
                            "View",
                            style: TextStyle(
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: <Widget>[
                          Icon(LineAwesomeIcons.trash, size: 18, color: Colors.red, ),
                          SizedBox(width: 5,),
                          Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.red),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailResultPage(listResultEntity: listResultEntity,)));
                    }else{
                      dialogToConfirm(context, message: "Delete ${listResultEntity!.name}?",
                        onTap: (){
                          context.read<ListResultBloc>().
                          add(DeleteListResultEvent(context: context, name: listResultEntity!.name));
                        }
                      );
                    }
                  },
                ),
              )
            ],
          )
      )
    );
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';

class ItemListResultWidget extends StatelessWidget{
  final int? index;
  final ListResultEntity? listResultEntityt;

  const ItemListResultWidget({this.index, this.listResultEntityt}) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context) =>
        //     ViewDetailBankPage(id: listBankEntity.id,)));
      },
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.chevron_right, size: 20,),
                ],
              ),
              SizedBox(height: 5,),
              Divider(thickness: 1,),
            ],
          )
      ),
    );
  }

}
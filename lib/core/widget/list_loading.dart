import 'package:flutter/material.dart';
import 'package:pl_calculation/core/platform/component.dart';

Widget listLoading(BuildContext context){
  return ListView.builder(
      padding: EdgeInsets.only(bottom: 20, top: 10, right: 15, left: 15),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: 5,
      itemBuilder: (context, i){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            ///Jumlah Tagihan bulan
            shimmerLine(width: autoSizedWidth(context, 0.6), height: 15),
            SizedBox(height: 5,),
            shimmerLine(width: autoSizedWidth(context, 0.4), height: 15),
            SizedBox(height: 5,),
            shimmerLine(width: autoSizedWidth(context, 1), height: 80),
          ],
        );
      }
  );


}
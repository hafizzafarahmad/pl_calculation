import 'package:flutter/material.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'result_page.dart';



class IndexResult extends StatefulWidget {
  final CalculateEntity? calculateEntity;

  const IndexResult({Key? key, this.calculateEntity}) : super(key: key);

  @override
  _IndexResult createState() => _IndexResult();
}

class _IndexResult extends State<IndexResult> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResultPage(calculateEntity: widget.calculateEntity,);
  }

}
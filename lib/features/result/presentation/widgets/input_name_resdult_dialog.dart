import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/features/result/domain/entities/calculate_entity.dart';
import 'package:pl_calculation/features/result/domain/entities/result_entity.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_bloc.dart';
import 'package:pl_calculation/features/result/presentation/bloc/result_event.dart';

class InputNameResultDialog extends StatefulWidget{
  final CalculateEntity? calculateEntity;
  final ResultEntity? resultEntity;

  const InputNameResultDialog({this.calculateEntity, this.resultEntity,}) : super();

  @override
  _InputNameResultDialog createState() => _InputNameResultDialog();
}

class _InputNameResultDialog extends State<InputNameResultDialog>{

  final _formKey = GlobalKey<FormState>();
  var _nameInput = TextEditingController();

  @override
  void dispose() {
    _nameInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 40),
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[

                  Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: _nameInput,
                    validator: (val){
                      if(val!.isEmpty){
                        return "Name cannot be blank";
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Card(
                      color: Pigment.fromString(PRIMARY_COLOR),
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: (){
                          hideKeyboard(context);
                          if(_formKey.currentState!.validate()){
                            context.read<ResultBloc>().add(SaveResultEvent(
                              context: context,
                              calculateEntity: widget.calculateEntity!,
                              resultEntity: widget.resultEntity,
                              name: _nameInput.text
                            ));
                          }
                        },
                        child: Container(
                            width: autoSizedWidth(context, 1),
                            height: 40,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3,),
                ],
              ),
            ),
          ),
        )
    );
  }
}

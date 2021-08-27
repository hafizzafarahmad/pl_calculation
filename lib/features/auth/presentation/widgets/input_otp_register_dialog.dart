import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/styles/inputStyle.dart';
import 'package:pl_calculation/core/widget/timer_button_custom.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_event.dart';

class InputOTPRegisterDialog extends StatefulWidget{
  final String? email;
  final String? token;
  final String? from;

  const InputOTPRegisterDialog({Key? key, this.email, this.token, this.from}) : super(key: key);

  @override
  _InputOTPRegisterDialog createState() => _InputOTPRegisterDialog();
}

class _InputOTPRegisterDialog extends State<InputOTPRegisterDialog>{

  var _codeInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: autoSizedWidth(context, 0.23)),
                  //   child: Image.asset(
                  //     'assets/icons/lock-otp.png',
                  //     fit: BoxFit.cover,
                  //     width: 50,
                  //   ),
                  // ),
                  Text(
                    'Verification Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PoppinsMedium',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(thickness: 1,),
                  SizedBox(height: 30,),
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Verification code already sent to: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: '${widget.email}.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _codeInput,
                    validator: (val){
                      if(val!.isEmpty){
                        return 'Code cannot be blank';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputStyle(context, hint: "Verification Code"),
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
                            context.read<AuthBloc>().add(SendOTPEvent(_codeInput.text, context, widget.from, widget.email));
                          }
                        },
                        child: Container(
                            width: autoSizedWidth(context, 1),
                            height: 40,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text(
                              'Verify',
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
                  TimerButtonCustom(
                    label: "Resend Code",
                    timeOutInSeconds: 30,
                    onPressed: () {
                      context.read<AuthBloc>().add(ResendOTPEvent(context, widget.email));
                    },
                    disabledColor: Colors.grey,
                    color: Colors.redAccent,
                    disabledTextStyle: new TextStyle(fontSize: 14.0, color: Pigment.fromString(PRIMARY_COLOR)),
                    activeTextStyle: new TextStyle(fontSize: 14.0, color: Pigment.fromString(PRIMARY_COLOR)),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

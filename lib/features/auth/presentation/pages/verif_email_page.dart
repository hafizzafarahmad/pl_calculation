
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_event.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_state.dart';

class VerifEmailPage extends StatefulWidget {
  final String? title;
  final bool? isAktivasi;

  const VerifEmailPage({Key? key, this.title  = "Forgot Password", this.isAktivasi = false}) : super(key: key);

  @override
  _VerifEmailPage createState() => _VerifEmailPage();
}

class _VerifEmailPage extends State<VerifEmailPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailInput = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailInput.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.watch<AuthBloc>().state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.title!, style: TextStyle(color: Colors.black, fontFamily: 'PoppinsMedium'),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(LineAwesomeIcons.angle_left, color: Colors.black,),
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyScrollBehavior(),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Enter yout registered email below to reset password.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30,),
                Form(
                  key: _formKey ,
                  child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Email cannot be blank';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Pigment.fromString(PRIMARY_COLOR)),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: 'Email',
                            prefixIcon: const Padding(padding: const EdgeInsets.all(0), child: const Icon(LineAwesomeIcons.at, color: Colors.red)),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ]
                  ),
                ),
                SizedBox(height: 20,),
                ///login button
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

                         context.read<AuthBloc>().add(ForgotPasswordEvent(context, _emailInput.text));

                        }
                      },
                      child: Container(
                          width: autoSizedWidth(context, 1),
                          height: 45,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: (authState is LoginLoading) ?
                          Center(child: CircularProgressIndicator(backgroundColor: Colors.white54, strokeWidth: 3,)) :
                          Center(child:
                          Text(
                            'Send',
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
                SizedBox(height: 80,),

                // Container(
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                //     width: autoSizedWidth(context, 1),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Pigment.fromString(BG_SELECT_PHOTO)
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           children: [
                //             Icon(Icons.info_outline, size: 20,),
                //             SizedBox(width: 10,),
                //             Expanded(child: Text(
                //               'Pastikan nomor HP dalam keadaan aktif untuk menerima SMS kode OTP.',
                //               style: TextStyle(
                //                   fontSize: 14,
                //                   fontFamily: 'PoppinsMedium'
                //               ),
                //             ))
                //           ],
                //         ),
                //       ],
                //     )
                // ),


              ],
            ),
          ),
        ),
      )
    );
  }

}
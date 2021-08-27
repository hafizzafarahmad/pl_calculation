
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

class ResetPasswordPage extends StatefulWidget {
  final String? title;

  const ResetPasswordPage({Key? key, this.title  = "Change Password"}) : super(key: key);

  @override
  _ResetPasswordPage createState() => _ResetPasswordPage();
}

class _ResetPasswordPage extends State<ResetPasswordPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _oldPasswordInput = TextEditingController();
  TextEditingController _passwordInput = TextEditingController();
  TextEditingController _confirmPasswordInput = TextEditingController();

  bool _obsecure = true;
  bool _confObsecure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordInput.dispose();
    _confirmPasswordInput.dispose();
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
                  'Your new password must be different from previous password',
                  style: TextStyle(
                    fontSize: 14,
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
                          controller: _oldPasswordInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Old password cannot be blank';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(13.0)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Pigment.fromString(PRIMARY_COLOR)),
                                  borderRadius: BorderRadius.circular(13.0)),
                              hintText: 'Old Password',
                              prefixIcon: const Padding(padding: const EdgeInsets.all(0), child: const Icon(LineAwesomeIcons.lock, color: Colors.red,)),
                              suffixIcon: IconButton(
                                  icon: _obsecure == true
                                      ? Icon(
                                    LineAwesomeIcons.eye,
                                    color: Colors.black87,
                                  )
                                      : Icon(
                                    LineAwesomeIcons.eye_slash,
                                    color: Colors.black87,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obsecure = !_obsecure;
                                    });
                                  })
                          ),
                          obscureText: _obsecure,
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: _passwordInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Password cannot be blank';
                            }
                            if(val == _oldPasswordInput.text){
                              return 'New Password must be different from previous password';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(13.0)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Pigment.fromString(PRIMARY_COLOR)),
                                  borderRadius: BorderRadius.circular(13.0)),
                              hintText: 'Password',
                              prefixIcon: const Padding(padding: const EdgeInsets.all(0), child: const Icon(LineAwesomeIcons.lock, color: Colors.red,)),
                              suffixIcon: IconButton(
                                  icon: _obsecure == true
                                      ? Icon(
                                    LineAwesomeIcons.eye,
                                    color: Colors.black87,
                                  )
                                      : Icon(
                                    LineAwesomeIcons.eye_slash,
                                    color: Colors.black87,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obsecure = !_obsecure;
                                    });
                                  })
                          ),
                          obscureText: _obsecure,
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: _confirmPasswordInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Confirm Password cannot be blank';
                            }
                            if(val != _passwordInput.text){
                              return 'password does not match';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(13.0)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Pigment.fromString(PRIMARY_COLOR)),
                                  borderRadius: BorderRadius.circular(13.0)),
                              hintText: 'Confirm Password',
                              prefixIcon: const Padding(padding: const EdgeInsets.all(0), child: const Icon(LineAwesomeIcons.lock, color: Colors.red,)),
                              suffixIcon: IconButton(
                                  icon: _confObsecure == true
                                      ? Icon(
                                    LineAwesomeIcons.eye,
                                    color: Colors.black87,
                                  )
                                      : Icon(
                                    LineAwesomeIcons.eye_slash,
                                    color: Colors.black87,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _confObsecure = !_confObsecure;
                                    });
                                  })
                          ),
                          obscureText: _confObsecure,
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 30,),
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
                          context.read<AuthBloc>().add(ResetPasswordEvent(context, _passwordInput.text, _oldPasswordInput.text));
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
                          Center(child: Text(
                            'Update',
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
                //               'Demi keamanan, minimal password harus mengandung huruf dan angka.',
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
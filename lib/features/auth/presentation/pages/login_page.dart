
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_event.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_state.dart';
import 'package:pl_calculation/features/auth/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailInput = TextEditingController();
  TextEditingController _passwordInput = TextEditingController();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailInput.dispose();
    _passwordInput.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.watch<AuthBloc>().state;

    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyScrollBehavior(),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
              // height: autoSizedHeight(context, 1),
              padding: EdgeInsets.only(top: autoSizedHeight(context, 0.03)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // height: autoSizedHeight(context, 0.9),
                    padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/arabica-1227.png',
                          fit: BoxFit.cover,
                          width: 180,
                        ),
                        Text(
                          'Engine Calculation',
                          style: TextStyle(
                            fontSize: 24,
                            color: Pigment.fromString(PRIMARY_COLOR),
                            fontFamily: 'PoppinsSemiBold'
                          ),
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
                                      return 'Email cannot be empty';
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
                                SizedBox(height: 20.0,),
                                TextFormField(
                                  controller: _passwordInput,
                                  validator: (val){
                                    if(val!.isEmpty){
                                      return 'Password cannot be empty';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Pigment.fromString(PRIMARY_COLOR)),
                                          borderRadius: BorderRadius.circular(10.0)),
                                      hintText: 'Password',
                                      prefixIcon: const Padding(padding: const EdgeInsets.all(0), child: const Icon(LineAwesomeIcons.lock, color: Colors.red,)),
                                      suffixIcon: IconButton(
                                          icon: _obscureText == true
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
                                              _obscureText = !_obscureText;
                                            });
                                          })
                                  ),
                                  obscureText: _obscureText,
                                ),
                              ]
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                hideKeyboard(context);
                                // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                //     VerifHpPage(title: "Lupa Password",)));
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'PoppinsSemiBold',
                                  color: Pigment.fromString(PRIMARY_COLOR),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
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
                                  context.read<AuthBloc>().add(LoginUserEvent(
                                      context,
                                      ParamsLogin(
                                          email: _emailInput.text,
                                          password: _passwordInput.text)));
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
                                    'Login',
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
                        SizedBox(height: 5,),

                        SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?  ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                              },
                              child: Text(
                                'Register here',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontWeight: FontWeight.bold,
                                  color: Pigment.fromString(PRIMARY_COLOR),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child:  Container(
                  //     alignment: Alignment.center,
                  //     width: MediaQuery.of(context).size.width,
                  //     child: Text(
                  //         (BASE_URL != 'http://newsmartsurvey2-cdc.apps.paas.telkom.co.id/web/api') ?
                  //         'Ver. 1.0.0-dev' : 'Ver. 1.0.0'
                  //     ),
                  //   ),
                  // )
                ],
              )
          ),
        ),
      )
    );
  }

}
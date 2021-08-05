import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/scroll_behavior.dart';
import 'package:pl_calculation/core/styles/inputStyle.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_event.dart';
import 'package:pl_calculation/features/auth/presentation/bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  var _nameInput = TextEditingController();
  var _emailInput = TextEditingController();
  var _passwordInput = TextEditingController();
  var _confirmPassword = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfPass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameInput.dispose();
    _emailInput.dispose();
    _confirmPassword.dispose();
    _passwordInput.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.watch<AuthBloc>().state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Register New Account', style: TextStyle(color: Colors.black, fontFamily: 'PoppinsMedium'),),
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
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 70),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[

                Form(
                  key: _formKey ,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ///NAMA
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
                          decoration: inputStyle(context, hint: "Full Name"),
                        ),
                        SizedBox(height: 10,),

                        ///Email
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _emailInput,
                          validator: (val){
                            bool isValid = EmailValidator.validate(val!);
                            if(val.isEmpty){
                              return 'Email cannot be blank';
                            }
                            if(!isValid){
                              return 'Email not valid';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: inputStyle(context, hint: "Account Email"),
                        ),
                        SizedBox(height: 10,),

                        ///PASSWORD
                        Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        TextFormField(
                          controller: _passwordInput,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Password cannot be null';
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
                                  icon: _obscurePass == true
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
                                      _obscurePass = !_obscurePass;
                                    });
                                  })
                          ),
                          obscureText: _obscurePass,
                        ),
                        SizedBox(height: 10,),

                        ///CONFIRM PASSWORD
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        TextFormField(
                          controller: _confirmPassword,
                          validator: (val){
                            if(val!.isEmpty){
                              return 'Confirm Password cannot be null';
                            }
                            if(val != _passwordInput.text){
                              return 'Confirm Password does not match';
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
                              prefixIcon: const Padding(padding: const EdgeInsets.all(0), child: const Icon(LineAwesomeIcons.unlock, color: Colors.red,)),
                              suffixIcon: IconButton(
                                  icon: _obscureConfPass == true
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
                                      _obscureConfPass = !_obscureConfPass;
                                    });
                                  })
                          ),
                          obscureText: _obscureConfPass,
                        ),
                      ]
                  ),
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
                          context.read<AuthBloc>().add(RegisterNewAccountEvent(
                            ParamsRegister(
                                nama: _nameInput.text,
                                email: _emailInput.text,
                                password: _passwordInput.text,
                                ),
                            context),
                          );
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
                            'Register',
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

                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?  ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login here',
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
        ),
      )
    );
  }

}
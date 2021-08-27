import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pigment/pigment.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/network/sp_database.dart';
import 'package:pl_calculation/core/platform/colors.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/permission.dart';
import 'package:pl_calculation/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/resend_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_otp_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';
import 'package:pl_calculation/features/auth/presentation/pages/index_auth.dart';
import 'package:pl_calculation/features/auth/presentation/widgets/input_otp_register_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final SendRegisterNewAccountUsecase? sendRegisterNewAccountUsecase;
  final SharedPreferences? sharedPreferences;
  final ResendOtpUsecase? resendOtpUsecase;
  final SendOTPUsecase? sendOTPUsecase;
  final LoginUsecase? loginUsecase;
  final ForgotPasswordUsecase? forgotPasswordUsecase;
  final ResetPasswordUsecase? resetPasswordUsecase;
  final PermissionChecker? permissionChecker;

  AuthBloc(
      {this.sendRegisterNewAccountUsecase, this.loginUsecase, this.forgotPasswordUsecase,
      this.sharedPreferences, this.resendOtpUsecase, this.sendOTPUsecase, this.resetPasswordUsecase,
        this.permissionChecker,}) : super(AuthInitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {

    if(event is AppStarted){



      await Future.delayed(Duration(seconds: 2));

      final token = sharedPreferences!.getString(TOKEN_CACHE);

      print("TOKEN $token");

      if(token != null && token.length > 10){
        yield Authenticated();
        // await permissionChecker.checkLocation();
        // await permissionChecker.checkCamera();
        // await permissionChecker.checkFolder();
      } else{
        yield Unauthenticated();
      }
    }

    if(event is LoginUserEvent){
      yield LoginLoading();
      final user = await loginUsecase!.call(event.paramsLogin);

      yield* user.fold((l) async*{
        yield LoginError('error login');

      }, (r) async* {
        yield Authenticated();
        // await permissionChecker.checkLocation();
        // await permissionChecker.checkCamera();
        // await permissionChecker.checkFolder();

      });
    }


    if(event is RegisterNewAccountEvent){
      loadingDialog(event.context).style(message: 'Register..');
      await loadingDialog(event.context).show();
      final register = await sendRegisterNewAccountUsecase!.call(event.paramsRegister);

      yield* register.fold((l) async*{
        await loadingDialog(event.context).hide();
      }, (r) async* {
        await loadingDialog(event.context).hide();
        showDialog(
            context: event.context,
            builder: (_) {
              return InputOTPRegisterDialog(email: event.paramsRegister.email, from: "register",);
            });

      });
    }

    if(event is LogoutUserEvent){
      String noHp;
      loadingDialog(event.context).style(message: 'Logout...');
      await loadingDialog(event.context).show();

      await sharedPreferences!.remove(TOKEN_CACHE);

      await Hive.deleteBoxFromDisk(BOX_MENU_LIST_RESULT);
      await Hive.deleteBoxFromDisk(BOX_RESULT);
      await Hive.deleteBoxFromDisk(BOX_CALCULATION);

      await loadingDialog(event.context).hide();

      yield Unauthenticated();

      Navigator.of(event.context).popUntil((route) => route.isFirst);

      // Navigator.pushAndRemoveUntil(
      //     event.context,
      //     MaterialPageRoute(builder: (BuildContext context) => IndexAuth()),
      //         (Route<dynamic> route) => false
      // );
    }


    if(event is ResendOTPEvent){
      final resent = await resendOtpUsecase!.call(ParamsResentOtp(email: event.email));

      yield* resent.fold((l) async*{
      }, (r) async* {
      });
    }

    if(event is SendOTPEvent){
      loadingDialog(event.context!).style(message: 'Please Wait...');
      await loadingDialog(event.context!).show();

      final otp = await sendOTPUsecase!.call(ParamsOTP(kode: event.kode, email: event.email));
      yield* otp.fold((l) async*{
        await loadingDialog(event.context!).hide();
        AwesomeDialog(
            context: event.context!,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,

            title: 'OTP Code Wrong/Expired',
            desc: 'please try again.',
            btnOkOnPress: () {
              if(event.from == "login"){

              } else if(event.from == "register"){
                // Navigator.pop(event.context!);
              } else {
                // Navigator.pop(event.context);
              }
            },
            btnOkColor: Pigment.fromString(PRIMARY_COLOR)
        )..show();

      }, (r) async* {
        await loadingDialog(event.context!).hide();
        AwesomeDialog(
            context: event.context!,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Success!',
            desc: 'Your account has been verified',
            btnOkOnPress: () {
              if(event.from == "login"){
                Navigator.pop(event.context!);
              }else{
                Navigator.pop(event.context!);
                Navigator.pop(event.context!);
              }
            },
            btnOkColor: Pigment.fromString(PRIMARY_COLOR)
        )..show();
      });
    }

    if(event is ForgotPasswordEvent){
      loadingDialog(event.context!).style(message: 'Please Wait...');
      await loadingDialog(event.context!).show();

      final otp = await forgotPasswordUsecase!.call(ParamsForgotPassword(email: event.email));
      yield* otp.fold((l) async*{
        await loadingDialog(event.context!).hide();
        AwesomeDialog(
            context: event.context!,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,

            title: 'Email Not Registered',
            desc: 'please try again.',
            btnOkOnPress: () {

            },
            btnOkColor: Pigment.fromString(PRIMARY_COLOR)
        )..show();

      }, (r) async* {
        await loadingDialog(event.context!).hide();
        AwesomeDialog(
            context: event.context!,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Success!',
            desc: 'Your account has been reset, please check your email.',
            btnOkOnPress: () {
              Navigator.pop(event.context!);
            },
            btnOkColor: Pigment.fromString(PRIMARY_COLOR)
        )..show();
      });
    }

    if(event is ResetPasswordEvent){
      loadingDialog(event.context!).style(message: 'Please Wait...');
      await loadingDialog(event.context!).show();

      final otp = await resetPasswordUsecase!.call(ParamsResetPassword(
          newPassword: event.password, oldPassword: event.oldPassword, context: event.context));
      yield* otp.fold((l) async*{
        await loadingDialog(event.context!).hide();
        AwesomeDialog(
            context: event.context!,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,

            title: 'Something Wrong!',
            desc: 'please try again.',
            btnOkOnPress: () {

            },
            btnOkColor: Pigment.fromString(PRIMARY_COLOR)
        )..show();

      }, (r) async* {
        await loadingDialog(event.context!).hide();
        AwesomeDialog(
            context: event.context!,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Success!',
            desc: 'Your password has been change.',
            btnOkOnPress: () {
              Navigator.pop(event.context!);
            },
            btnOkColor: Pigment.fromString(PRIMARY_COLOR)
        )..show();
      });
    }
  }

}
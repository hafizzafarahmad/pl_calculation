import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pl_calculation/core/database/hive_database.dart';
import 'package:pl_calculation/core/network/sp_database.dart';
import 'package:pl_calculation/core/platform/component.dart';
import 'package:pl_calculation/core/platform/permission.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';
import 'package:pl_calculation/features/auth/presentation/pages/index_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final SendRegisterNewAccountUsecase? sendRegisterNewAccountUsecase;
  final SharedPreferences? sharedPreferences;
  final LoginUsecase? loginUsecase;
  final PermissionChecker? permissionChecker;

  AuthBloc(
      {this.sendRegisterNewAccountUsecase, this.loginUsecase,
      this.sharedPreferences,
      this.permissionChecker,}) : super(AuthInitialized());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {

    if(event is AppStarted){

      await Future.delayed(Duration(seconds: 2));

      final token = sharedPreferences!.getString(TOKEN_CACHE);

      print("TOKEN $token");

      if(token != null){
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
        alertToast("Register Success");
        Navigator.pop(event.context);

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

      Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(builder: (BuildContext context) => IndexAuth()),
              (Route<dynamic> route) => false
      );
    }


  }

}
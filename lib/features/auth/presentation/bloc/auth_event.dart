import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pl_calculation/features/auth/domain/usecase/login_usecase.dart';
import 'package:pl_calculation/features/auth/domain/usecase/send_register_new_account_usecase.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent{
  final BuildContext context;

  AppStarted(this.context);

  @override
  List<Object> get props => [context];
}

class RegisterNewAccountEvent extends AuthEvent {
  final ParamsRegister paramsRegister;
  final BuildContext context;

  RegisterNewAccountEvent(this.paramsRegister, this.context);

  @override
  List<Object> get props => [paramsRegister];
}

class LoginUserEvent extends AuthEvent {
  final BuildContext context;
  final ParamsLogin paramsLogin;

  LoginUserEvent(this.context, this.paramsLogin);

  @override
  List<Object> get props => [context, paramsLogin];
}


class LogoutUserEvent extends AuthEvent {
  final BuildContext context;

  LogoutUserEvent(this.context);
  @override
  String toString() => 'LOGGED OUT';

  @override
  List<Object> get props => [context];
}


class SendOTPEvent extends AuthEvent {
  final String? kode;
  final BuildContext? context;
  final String? from;
  final String? email;

  SendOTPEvent(this.kode, this.context,this.from, this.email);

  @override
  List<Object> get props => [kode!, context!, from!, email!];
}

class ResendOTPEvent extends AuthEvent{
  final BuildContext? context;
  final String? email;

  ResendOTPEvent(this.context, this.email);

  @override
  String toString() => 'ResendOTP';

  @override
  List<Object> get props => [email!, context!];
}

class ForgotPasswordEvent extends AuthEvent{
  final BuildContext? context;
  final String? email;

  ForgotPasswordEvent(this.context, this.email);

  @override
  String toString() => 'ResendOTP';

  @override
  List<Object> get props => [email!, context!];
}

class ResetPasswordEvent extends AuthEvent{
  final BuildContext? context;
  final String? oldPassword;
  final String? password;

  ResetPasswordEvent(this.context, this.password, this.oldPassword);

  @override
  String toString() => 'ResendOTP';

  @override
  List<Object> get props => [password!, context!, oldPassword!];
}


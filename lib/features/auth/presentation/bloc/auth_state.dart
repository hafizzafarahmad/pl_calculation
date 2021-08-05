import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

///AUTH
class AuthInitialized extends AuthState {}

class Authenticated extends AuthState {
  // final LoginEntity loginEntity;
  //
  // Authenticated({this.loginEntity});
  //
  // @override
  // List<Object> get props => [loginEntity];
}

class AuthLoading extends AuthState {}

class Unauthenticated extends AuthState {}


///LOGIN
class LoginInitialized extends AuthState {}

class LoginLoading extends AuthState {}

class LoginError extends AuthState {
  final String messages;

  LoginError(this.messages);

  @override
  String toString() => 'LOGIN ERROR: $messages';

  @override
  List<Object> get props => [messages];
}

part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState{
  final AuthModel authSuccess;
  AuthSuccess({@required this.authSuccess});
}

class AuthError extends AuthState{
  final String errorMessage;
  AuthError({this.errorMessage});
}

class AuthRegisterSuccess extends AuthState{
  final int value;
  final String message;
  final String email;
  AuthRegisterSuccess({this.value,this.message, this.email}); 
}

class AuthWaiting extends AuthState{}
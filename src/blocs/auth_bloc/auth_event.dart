part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent{
  final AuthModel authRequest;
  LoginEvent({@required this.authRequest});
}

class RegisterEvent extends AuthEvent{
  final AuthRegister authRegister;
  RegisterEvent({@required this.authRegister});
}
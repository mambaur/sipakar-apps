import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipakar_apps/src/models/auth-model.dart';
import 'package:sipakar_apps/src/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _authLogin(event.authRequest);
    } else if (event is RegisterEvent) {
      yield* _authRegister(event.authRegister);
    }
  }

  Stream<AuthState> _authLogin(AuthModel request) async* {
    AuthRepository _authRepository = AuthRepository();

    yield AuthWaiting();
    try {
      AuthModel data = await _authRepository.postAuth(request);
      // print(data.email);
      yield AuthSuccess(authSuccess: data);
    } catch (e) {
      yield AuthError(errorMessage: e.toString());
    }
  }

  Stream<AuthState> _authRegister(AuthRegister request) async* {
    AuthRepository _authRepository = AuthRepository();

    yield AuthWaiting();
    try {
      var data = await _authRepository.postAuthRegister(request);
      print("bloc message: Insert data berhasil");
      yield AuthRegisterSuccess(
          value: data['value'], message: data['message'], email: data['email']);
    } catch (e) {
      yield AuthError(errorMessage: e.toString());
    }
  }
}

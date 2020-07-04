import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipakar_apps/src/models/account.dart';
import 'package:sipakar_apps/src/repositories/account_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  @override
  AccountState get initialState => AccountInitial();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is GetEmailEvent){
      yield* _allDataUser(event.email);
    }
    if (event is ChangeEdit){
      yield* _changeEdit(event.email);
    }
    if (event is UpdateData){
      yield* _updateData(event.accountDataRequest);
    }
    if (event is UpdatePassword){
      yield* _changePassword(event.email, event.password);
    }
  }

  Stream<AccountState> _allDataUser(String request) async* {
    AccountRepository _accountRepository = AccountRepository();

    yield AccountWaiting();
    try {
      AccountModel data = await _accountRepository.getIdEmail(request);
      yield AccountData(dataUser: data);
    } catch (e) {
      yield  AccountError(errorMessage: e.toString());
    }
  }

  Stream<AccountState> _changeEdit(String request) async* {
    AccountRepository _accountRepository = AccountRepository();

    yield AccountWaiting();
    try {
      AccountModel data = await _accountRepository.getIdEmail(request);
      yield EditView(dataUser: data);
    } catch (e) {
      yield  AccountError(errorMessage: e.toString());
    }
  }

  Stream<AccountState> _updateData(AccountModel request) async* {
    AccountRepository _accountRepository = AccountRepository();

    yield AccountWaiting();
    try {
      var data = await _accountRepository.updateAccount(request);
      print("Update data berhasil, Response : $data");
      yield UpdateSuccess(value: data['value'], message: data['message']);
    } catch (e) {
      yield  AccountError(errorMessage: e.toString());
    }
  }

  Stream<AccountState> _changePassword(String email, String password) async* {
    AccountRepository _accountRepository = AccountRepository();

    yield AccountWaiting();
    try {
      var data = await _accountRepository.postChangePassword(email,password);
      print('Password berhasil diganti, response : $data');
      yield ChangePasswordSuccess(value: data['value'], message: data['message']);
    } catch (e) {
      yield  AccountError(errorMessage: e.toString());
    }
  }
}

part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {
}

class AccountWaiting extends AccountState{}

class AccountData extends AccountState{
  final AccountModel dataUser;
  AccountData({@required this.dataUser});
}

class EditView extends AccountState{
  final AccountModel dataUser;
  EditView({@required this.dataUser});
}

class UpdateSuccess extends AccountState{
  final String message;
  final int value;
  UpdateSuccess({this.value, this.message});
}

class ChangePasswordSuccess extends AccountState{
  final String message;
  final int value;
  ChangePasswordSuccess({this.value, this.message});
}

class AccountError extends AccountState{
  final String errorMessage;
 AccountError({this.errorMessage});
}

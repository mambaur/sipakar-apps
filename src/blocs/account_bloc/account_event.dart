part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}


class GetEmailEvent extends AccountEvent{
  final String email;
  GetEmailEvent({this.email});
}

class ChangeEdit extends AccountEvent{
  final String email;
  ChangeEdit({this.email});
}

class UpdatePassword extends AccountEvent{
  final String email,password;
  UpdatePassword({this.password, this.email});
}

class UpdateData extends AccountEvent{
  final AccountModel accountDataRequest;
  UpdateData({this.accountDataRequest});
}
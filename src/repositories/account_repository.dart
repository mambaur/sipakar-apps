import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sipakar_apps/src/models/account.dart';

// http://192.168.43.206/skripsi/

class AccountRepository {
  Future getIdEmail(String email) async {
    try {
      http.Response response = await http.post(
          'https://sipakar.caraguna.com/api/account/getId/',
          body: {'email': email});
      var dataResponse = json.decode(response.body);
      AccountModel data = AccountModel.fromJson(dataResponse);
      return data;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future updateAccount(AccountModel accountModel) async {
    try {
      http.Response response = await http.post(
          'https://sipakar.caraguna.com/api/account/updateData/',
          body: accountModel.toJson());
      var dataResponse = json.decode(response.body);
      return dataResponse;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future postChangePassword(email, password) async {
    try {
      http.Response response = await http.post(
          'https://sipakar.caraguna.com/api/account/changePassword/',
          body: {'email': email, 'password': password});
      var dataResponse = json.decode(response.body);
      return dataResponse;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sipakar_apps/src/models/auth-model.dart';

class AuthRepository {
  Future<AuthModel> postAuth(AuthModel authData) async {
    AuthCache _authcache = AuthCache();
    try {
      http.Response response = await http.post(
          'http://192.168.43.206/skripsi/api/auth',
          body: authData.toJson());
      var authResponse = json.decode(response.body);
      AuthModel auth = AuthModel.fromJson(authResponse);
      await _authcache.savePref(authResponse['value'],
          auth.email.toString()); //Login cache shared preference
      return auth;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future postAuthRegister(AuthRegister authData) async {
    try {
      http.Response response = await http.post(
          'http://192.168.43.206/skripsi/api/auth/register',
          body: authData.toJson());
      var authResponse = json.decode(response.body);
      // print(authResponse);
      return authResponse;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

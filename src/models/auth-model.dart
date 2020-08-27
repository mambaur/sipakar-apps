import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipakar_apps/src/views/auth/login_screen.dart';

class AuthModel {
  String email;
  String password;

  AuthModel({this.email, this.password});

  AuthModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class AuthCache {
  Future savePref(value, email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.setString("email", email);
  }

  Future getPref() async {
    int value;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    value = preferences.getInt("value");
    value == 1
        ? print('Status anda saat ini Login ($value)')
        : print('Status anda saat ini tidak login ($value)');
    return value;
  }

  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", null);
    print('Anda berhasil logout');
    Flushbar(
                  message:
                     "Anda berhasil logout",
                  duration: Duration(seconds: 2),
                ).show(context);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

class AuthRegister {
  String name, email, password, address;

  AuthRegister({this.name, this.email, this.password, this.address});

  AuthRegister.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    return data;
  }
}

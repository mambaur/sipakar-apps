import 'package:shared_preferences/shared_preferences.dart';

class AccountModel {
  String name, email, address, password;

  AccountModel({this.name, this.email, this.address, this.password});

  AccountModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['password'] = this.password;
    return data;
  }
}

class GetIdPref {
  Future getPref() async {
    String value;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    value = preferences.getString("email");
    return value;
  }
}

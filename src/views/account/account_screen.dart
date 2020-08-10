import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipakar_apps/src/blocs/account_bloc/account_bloc.dart';
import 'package:sipakar_apps/src/models/account.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AccountBloc _accountBloc = AccountBloc();
  GetIdPref _accountModel = GetIdPref();
  final _keyData = new GlobalKey<FormState>();
  final _keyPassword = new GlobalKey<FormState>();
  String name, email, address, oldPassword, newPassword, passwordConfirmation;

  //vallidate input Form edit
  checkFormEditData() {
    final form = _keyData.currentState;
    if (form.validate()) {
      form.save();
      AccountModel dataRequest = AccountModel(
          email: email, name: name, address: address, password: "null");
      _accountBloc.add(UpdateData(accountDataRequest: dataRequest));
    }
  }

  //vallidate input Form password
  checkFormPassword() async{
    final form = _keyPassword.currentState;
    if (form.validate()) {
      form.save();
      String email;
      email = await _accountModel.getPref();
      _accountBloc.add(UpdatePassword(password: newPassword, email: email));
    }
  }

  getDataAccount() async {
    String email;
    email = await _accountModel.getPref();
    _accountBloc.add(GetEmailEvent(email: email));
  }

  eventEdit(String tombol) async {
    if (tombol == "changeEdit") {
      String email;
      email = await _accountModel.getPref();
      _accountBloc.add(ChangeEdit(email: email));
    } else if (tombol == "backEdit") {
      getDataAccount();
    }
  }

  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    getDataAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AccountBloc, AccountState>(
        bloc: _accountBloc,
        listener: (BuildContext context, state) {
          if (state is UpdateSuccess) {
            Fluttertoast.showToast(
              msg: state.message,
              timeInSecForIosWeb: 4,
            );
            getDataAccount();
          }
          if (state is ChangePasswordSuccess) {
            Fluttertoast.showToast(
              msg: state.message,
              timeInSecForIosWeb: 4,
            );
            getDataAccount();
          }
        },
        child: Scaffold(
            body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue[900],
                        Colors.blue[600],
                        Colors.blue[300],
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Akun Anda",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Pengaturan akun",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: BlocBuilder<AccountBloc, AccountState>(
                        bloc: _accountBloc,
                        builder: (context, state) {
                          if (state is AccountData) {
                            return _buttonEdit(
                                "Edit", "changeEdit", Icons.edit);
                          }
                          if (state is EditView) {
                            return _buttonEdit(
                                "Kembali", "backEdit", Icons.arrow_back);
                          }
                          return _buttonEdit("Edit", "changeEdit", Icons.edit);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40, top: 100),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue[400],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue[600],
                            Colors.blue[200],
                          ],
                        ),
                      ),
                      child: ClipOval(
                          child: Icon(
                        Icons.account_circle,
                        color: Colors.grey[200],
                        size: 150,
                      )),
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<AccountBloc, AccountState>(
              bloc: _accountBloc,
              builder: (context, state) {
                if (state is AccountWaiting) {
                  return Container(
                      margin: EdgeInsets.all(100),
                      child: Center(child: CircularProgressIndicator()));
                }
                if (state is AccountData) {
                  return _accountInfo(state.dataUser);
                }
                if (state is EditView) {
                  return _textfieldEdit(state.dataUser);
                }
                return Container(
                    margin: EdgeInsets.all(100),
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
          ],
        )),
      ),
    );
  }

  Container _textfieldEdit(AccountModel state) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 5, top: 30, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Edit data anda",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Kamu dapat mengubah datamu disini",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )),
          Form(
            key: _keyData,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextFormField(
                        onSaved: (e) => email = e,
                        readOnly: true,
                        initialValue: state.email,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "*Email tidak boleh kosong";
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(Icons.edit_attributes),
                                onPressed: null),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextFormField(
                        onSaved: (e) => name = e,
                        initialValue: state.name,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "*Nama tidak boleh kosong";
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(Icons.edit), onPressed: null),
                            hintText: "Nama",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextFormField(
                        onSaved: (e) => address = e,
                        initialValue: state.address,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "*Alamat tidak boleh kosong";
                          }
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(Icons.edit), onPressed: null),
                            hintText: "Alamat",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, top: 5),
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: () {
                checkFormEditData();
              },
              child: Text(
                'Update Data',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue[300],
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 5, top: 30, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Ubah Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Kamu dapat mengubah password disini",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )),
          Form(
            key: _keyPassword,
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]))),
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (e) => oldPassword = e,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "*Password lama tidak boleh kosong";
                        }
                        if (e != state.password) {
                          return "*Password lama salah";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Password lama",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]))),
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (e) => newPassword = e,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "*Password baru tidak boleh kosong";
                        }
                        if (e == oldPassword) {
                          return "*Password lama harus berbeda dengan password baru";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Password baru",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (e) => passwordConfirmation = e,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "*Konfirmasi password tidak boleh kosong";
                        } else if (newPassword != e) {
                          return "*Konfirmasi password tidak sama";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Konfirmasi password",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, top: 5, bottom: 10),
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: () {
                checkFormPassword();
              },
              child: Text(
                'Ubah Password',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue[300],
            ),
          ),
        ],
      ),
    );
  }

  Container _buttonEdit(String title, String buttonKey, IconData icon) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.grey[200],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            colors: [
              Colors.blue[800],
              Colors.blue[700],
              Colors.blue[500],
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            splashColor: Colors.black,
            onTap: () {
              eventEdit(buttonKey);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(title,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
          ),
        ));
  }

  Column _accountInfo(AccountModel state) {
    return Column(
      children: <Widget>[
        Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Email ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(state.email, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            )),
        Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Nama',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(state.name, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            )),
        
        Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {},
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Alamat ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(state.address,
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: Text(
              "Sipakar v.1",
              style: TextStyle(color: Colors.grey, fontSize: 15, fontStyle: FontStyle.italic),
            ))
      ],
    );
  }
}

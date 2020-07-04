import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipakar_apps/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:sipakar_apps/src/models/auth-model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipakar_apps/src/sipakar-apps.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthCache _authCache = AuthCache();
  AuthBloc _authBloc;
  final _key = new GlobalKey<FormState>();
  String name, email, address, password, passwordConfirmation;

  //vallidate input
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      AuthRegister registerRequest = AuthRegister(
          name: name, email: email, password: password, address: address);
      _authBloc.add(RegisterEvent(authRegister: registerRequest));
    }
  }

  //check shared preference login
  var value;
  getPref() async {
    value = await _authCache.getPref();
    setState(() {
      value == 1
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SipakarApps()))
          : print('Login status [0]');
    });
  }

  @override
  void initState() {
    getPref();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (BuildContext context, state) {
          if (state is AuthRegisterSuccess) {
            if (state.value == 1) {
              Fluttertoast.showToast(
                msg: state.message,
                timeInSecForIosWeb: 4,
              );
              _authCache.savePref(state.value, state.email);
              setState(() {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SipakarApps()));
              });
            } else {
              Fluttertoast.showToast(
                msg: state.message,
                timeInSecForIosWeb: 4,
              );
            }
          }
          if (state is AuthError) {
            Fluttertoast.showToast(
              msg: state.errorMessage,
              timeInSecForIosWeb: 4,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Register Account',
              style: TextStyle(color: Color.fromRGBO(38, 81, 158, 1)),
            ),
            backgroundColor: Colors.transparent,
            leading: Builder(builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.all(0),
                child: IconButton(
                  icon: Icon(Icons.chevron_left),
                  color: Color.fromRGBO(38, 81, 158, 1),
                  onPressed: () => Navigator.pop(context),
                ),
              );
            }),
            elevation: 0,
          ),
          body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthWaiting) {
              return Stack(
                children: <Widget>[
                  _listFormInput(),
                  Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: Center(child: CircularProgressIndicator()))
                ],
              );
            }
            if (state is AuthError) {
              return _listFormInput();
            }
            return _listFormInput();
          }),
        ),
      ),
    );
  }

  ListView _listFormInput() {
    return ListView(scrollDirection: Axis.vertical, children: <Widget>[
      Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Text(
            "*Please insert your data",
            style: TextStyle(color: Colors.grey),
          )),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[200]))),
                        child: TextFormField(
                          onChanged: (e) => name = e,
                          validator: (e) {
                            if (e.isEmpty) {
                              return "*Please insert your name";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Your Name",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[200]))),
                        child: TextFormField(
                          onChanged: (e) => email = e,
                          validator: (e) {
                            if (e.isEmpty) {
                              return "*Please insert your email";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          onChanged: (e) => address = e,
                          validator: (e) {
                            if (e.isEmpty) {
                              return "*Please insert your address";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Address",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin:
                    EdgeInsets.only(bottom: 5, top: 20, right: 10, left: 10),
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
                        onChanged: (e) => password = e,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "*Please insert password";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
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
                            return "*Please insert password confirmation";
                          } else if (password != e) {
                            print(password);
                            print(e);
                            return "*Password confirmation doesn't match";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Password Confirmation",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                  ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          check();
                        },
                        splashColor: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: Text("Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipakar_apps/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:sipakar_apps/src/models/auth-model.dart';
import 'package:sipakar_apps/src/sipakar-apps.dart';
import 'package:sipakar_apps/src/views/auth/register_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  AuthCache _authCache = AuthCache();
  final _key = new GlobalKey<FormState>();
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username, password;
  bool _secureText = true;
  AuthBloc _authBloc;

  //Show password obsecure input
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  //vallidate input
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      AuthModel loginRequest = AuthModel(email: username, password: password);
      _authBloc.add(LoginEvent(authRequest: loginRequest));
    }
  }

  //check shared preference login
  var value;
  getPref() async {
    value = await _authCache.getPref();
    setState(() {
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
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
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return BlocListener<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is AuthSuccess) {
              getPref();
              state.authSuccess.email == null &&
                      state.authSuccess.password == null
                  ? Flushbar(
                  message:
                      "Please check your username or password!",
                  duration: Duration(seconds: 2),
                ).show(context)
                  :Flushbar(
                  message:
                      "Welcome to Sipakar!",
                  duration: Duration(seconds: 2),
                ).show(context); 
            }
            if (state is AuthError) {
              Flushbar(
                  message:
                      state.errorMessage,
                  duration: Duration(seconds: 2),
                ).show(context);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthWaiting) {
              return Stack(
                children: <Widget>[
                  _loginScaffold(context),
                  Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: Center(child: CircularProgressIndicator()))
                ],
              );
            }
            return _loginScaffold(context);
          }),
        );
        break;
      case LoginStatus.signIn:
        return SipakarApps();
        break;
    }
  }

  Scaffold _loginScaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[900],
              Colors.blue[800],
              Colors.blue[400],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Selamat datang!",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: _key,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 60),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, .1),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                          onSaved: (e) => username = e,
                                          validator: (e) {
                                            if (e.isEmpty) {
                                              return "*Please insert email or phone";
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Email atau nomor telepon",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                          onSaved: (e) => password = e,
                                          validator: (e) {
                                            if (e.isEmpty) {
                                              return "*Please insert password";
                                            }
                                          },
                                          obscureText: _secureText,
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              color: Colors.grey,
                                              onPressed: showHide,
                                              icon: Icon(_secureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(height: 40),
                              // Text(
                              //   "Forgot Password?",
                              //   style: TextStyle(color: Colors.grey),
                              // ),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  BlocBuilder<AuthBloc, AuthState>(
                                      bloc: _authBloc,
                                      builder: (context, state) {
                                        if (state is AuthWaiting) {
                                          // return CircularProgressIndicator();
                                          return _loginButton();
                                        }
                                        if (state is AuthSuccess) {
                                          return _loginButton();
                                        }
                                        if (state is AuthError) {
                                          return _loginButton();
                                        }

                                        return _loginButton();
                                      }),
                                  _registerButton(context)
                                ],
                              ),
                            ],
                          ),
                        ))))
          ],
        ),
      ),
    );
  }

  Container _loginButton() {
    return Container(
      height: 50,
      width: 170,
      decoration: BoxDecoration(
        color: Colors.lightBlue[900],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              // pr.show();
              // pr.hide().whenComplete(() {
              check();
              // });
            },
            splashColor: Colors.lightBlue,
            borderRadius: BorderRadius.circular(50),
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthWaiting) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          value: 1.0,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                );
              }
              if (state is AuthSuccess) {
                return Center(child: _loginText());
              }
              return Center(child: _loginText());
            })),
      ),
    );
  }

  Text _loginText() {
    return Text("Login", style: TextStyle(color: Colors.white, fontSize: 13));
  }

  Container _registerButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              child: Text(
                "Daftar",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ));
  }
}

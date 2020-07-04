import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sipakar_apps/src/blocs/disease_bloc/disease_bloc.dart';
import 'package:sipakar_apps/src/models/auth-model.dart';
import 'package:sipakar_apps/src/views/start_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProgressDialog pr;
  AuthCache _authCache = AuthCache();
  DiseaseBloc _diseaseBloc = DiseaseBloc();

  @override
  void initState() {
    _diseaseBloc = BlocProvider.of<DiseaseBloc>(context);
    _diseaseBloc.add(GetListDisease());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue[900],
                Colors.blue[400],
                Colors.blue[400],
              ],
            ),
          ),
          child: BlocBuilder<DiseaseBloc, DiseaseState>(
            bloc: _diseaseBloc,
            builder: (context, state) {
              if (state is DiseaseWaiting) {
                return _shimmerEffect(context);
              }
              if (state is DiseaseLoaded) {
                return _homeView(context, state);
                // return _shimmerEffect(context);
              }
              if (state is DiseaseError) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image(
                          width: 250,
                          image: AssetImage('assets/no-connection.jpg'),
                        ),
                      ),
                      Text('No internet connection'),
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            _diseaseBloc.add(GetListDisease());
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: 90,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey[300])),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.refresh,
                                    size: 15,
                                  ),
                                  Text('Refresh'),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                );
              }
              if (state is DiseaseDetailWaiting) {
                return Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator()));
              }
              if (state is DiseaseById) {
                return _detailDisease(state);
              }

              return _shimmerEffect(context);
            },
          ),
        ),
      ),
    );
  }

  Scaffold _detailDisease(DiseaseById state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Detail Disease',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          leading: GestureDetector(
            onTap: () {
              _diseaseBloc.add(GetListDisease());
            },
            child: Container(
                child: Icon(
              Icons.chevron_left,
              size: 40,
              color: Colors.grey[300],
            )),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey[200],
                          child: Image.network(
                            "http://192.168.43.206/sipakar/${state.data.gambar}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.all(10),
                          height: 300,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                state.data.namaPenyakit,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  state.data.idpenyakit,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Tobacco Disease',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(state.data.penanganan),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _diseaseBloc.add(GetListDisease());
                },
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.chevron_left, color: Colors.grey),
                        Text("Back")
                      ]),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }

  Container _shimmerEffect(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Shimmer.fromColors(
        highlightColor: Colors.grey[100],
        baseColor: Colors.grey[300],
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 30,
                        width: 190,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 20,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        size: 55,
                      ),
                      Icon(
                        Icons.exit_to_app,
                        size: 55,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 15),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: <Widget>[
                  Container(
                    height: 120,
                    margin: EdgeInsets.all(10),
                  ),
                ]),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
            )
          ]),
        ),
      ),
    );
  }

  SingleChildScrollView _homeView(BuildContext context, DiseaseLoaded state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _headerApp(context),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('List disease tobacco',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,)),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                )
              ],
            ),
          ),
          SizedBox(
            child: Container(
              height: 110,
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal:10, vertical:1),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.listDisease.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: _listDiseaseHome(
                            state.listDisease[index].gambar,
                            state.listDisease[index].namaPenyakit,
                            state.listDisease[index].idpenyakit));
                  }),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                )),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 3,
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.add_alarm,
                              size: 40,
                            ),
                            Text(
                              "Sistem pakar adalah sistem",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.add_shopping_cart,
                              size: 40,
                            ),
                            Text("Sistem pakar adalah sistem",
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.adjust,
                              size: 40,
                            ),
                            Text("Sistem pakar adalah sistem",
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("What is Sipakar?",
                            style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                            )),
                        Text(
                            "Sistem pakar adalah sistem yang mampu Lorem ipusm dolor love memorandum ndose pakar adalah sistem yang mampu Lorem ipusm dolor love memorandum ndose Lorem ipusm dolor love memorandum ndose pakar adalah",
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [
                        Colors.blue[800],
                        Colors.blue[600],
                        Colors.blue[400],
                      ],
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Future.delayed(Duration(seconds: 3), () {
                          print('ok');
                        });

                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => StartScreen()),
                        );
                      },
                      splashColor: Colors.blue[900],
                      borderRadius: BorderRadius.circular(40),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Sipakar v.1",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                        color: Colors.grey))
              ],
            ),
          )
        ],
      ),
    );
  }

  _headerApp(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.web,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        'SiPakar',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    'Tobbaco plant disease',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.blue[100]),
                  ),
                ],
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          ConfirmAlertBox(
                              title: "Logout",
                              infoMessage: "Are you sure want to logout?",
                              context: context,
                              onPressedYes: () async {
                                await _authCache.logout(context);
                              });
                        },
                        splashColor: Colors.black,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _listDiseaseHome(String src, String text, String idpenyakit) {
    return GestureDetector(
      onTap: () {
        _diseaseBloc.add(GetDiseaseById(idpenyakit: idpenyakit));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 80,
                width: 90,
                child: Image.network(
                  'http://192.168.43.206/sipakar/$src',
                  fit: BoxFit.cover,
                )),
            Container(
              width: 90,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
              child: Column(
                children: <Widget>[
                  Text(text,
                      style: TextStyle(color: Colors.black, fontSize: 10),
                      textAlign: TextAlign.center),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

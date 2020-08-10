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
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: SafeArea(
        child: Container(
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
          backgroundColor: Colors.white,
          title: Text(
            state.data.namaPenyakit,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              _diseaseBloc.add(GetListDisease());
            },
            child: Container(
                child: Icon(
              Icons.arrow_back,
              // size: 20,
              color: Colors.grey[700],
            )),
          ),
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
                            "http://192.168.43.206/skripsi/assets/images/${state.data.gambar}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 300,
                          child: Container(
                              width: double.infinity,
                              color: Colors.white.withOpacity(0.5),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                state.data.namaPenyakit,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
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
                                  'Penyakit Tanaman tembakau',
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
                        Text("Kembali")
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

  _shimmerEffect(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        highlightColor: Colors.grey[100],
        baseColor: Colors.grey[300],
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Flexible(
              flex: 8,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.grey),
              ),
            ),
            Flexible(
              flex: 4,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 9,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> refresh() async {
    _diseaseBloc.add(GetListDisease());
  }

  _homeView(BuildContext context, DiseaseLoaded state) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          onRefresh: () {
            return refresh();
          },
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 80),
                child: Image(
                  image: AssetImage('assets/homeflat.png'),
                  width: 300.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconCard(text: 'Masukkan gejala', icon: Icons.input),
                    IconCard(text: 'Identifikasi', icon: Icons.replay),
                    IconCard(text: 'Hasil Identifikasi', icon: Icons.check_box),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 15, left: 15),
                    child: Image(
                      image: AssetImage('assets/plant.png'),
                      width: 100,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text('Apa itu SiPakar?',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('SiPakar adalah sistem pakar tanaman',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            )),
                        Text('tembakau identifikasi penyakit ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            )),
                        Text('tanaman tembakau',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Daftar penyakit tanaman tembakau',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.grey[300],
                      size: 15,
                    )
                  ],
                ),
              ),
              Container(
                height: 180,
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 2))
                    ]),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 165,
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 1),
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
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => StartScreen()),
                      );
                    },
                    splashColor: Colors.blue[900],
                    borderRadius: BorderRadius.circular(40),
                    child: Center(
                      child: Text(
                        'Mulai Identifikasi',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        _headerApp(context),
      ],
    );
  }

  _headerApp(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 3)
      ]),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'SiPakar',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[800]),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.account_circle,
                        size: 30.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          ConfirmAlertBox(
                              title: "Keluar",
                              infoMessage: "Apakah anda yakin ingin keluar?",
                              buttonColorForNo: Colors.grey[200],
                              buttonTextColorForNo: Colors.grey,
                              buttonTextForYes: "Ya, keluar",
                              buttonTextForNo: "Batal",
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
                            color: Colors.grey[300],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Container(
                height: 135,
                width: 125,
                child: Image.network(
                  'http://192.168.43.206/skripsi/assets/images/$src',
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 2,
          ),
          Center(
            child: Text(text,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final String text;
  final IconData icon;
  const IconCard({
    Key key,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: 80,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.grey[800]),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

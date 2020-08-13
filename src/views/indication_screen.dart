import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sipakar_apps/src/blocs/indication_bloc/indication_bloc.dart';

class IndicationScreen extends StatefulWidget {
  @override
  _IndicationScreenState createState() => _IndicationScreenState();
}

class _IndicationScreenState extends State<IndicationScreen> {
  IndicationBloc _indicationBloc = IndicationBloc();

  @override
  void initState() {
    _indicationBloc = BlocProvider.of<IndicationBloc>(context);
    _indicationBloc.add(GetIndication());
    super.initState();
  }

  bool leading = false;
  bool centerTitle = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<IndicationBloc, IndicationState>(
        bloc: _indicationBloc,
        listener: (context, state) {
          if (state is IndicationError) {
            Fluttertoast.showToast(
              msg: state.errorMessage,
              timeInSecForIosWeb: 4,
            );
          }
        },
        child: Container(
          // margin: EdgeInsets.only(top: 5),
          child: BlocBuilder<IndicationBloc, IndicationState>(
            bloc: _indicationBloc,
            builder: (context, state) {
              if (state is IndicationWaiting) {
                return _shimmerEffect(context);
              }
              if (state is IndicationDetailWaiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is IndicationGetAll) {
                return _listDataIndication(state);
                // return _shimmerEffect(context);
              }
              if (state is IndicationById) {
                return _detailDataIndication(state);
              }
              return _shimmerEffect(context);
            },
          ),
        ),
      ),
    );
  }

  SafeArea _detailDataIndication(IndicationById state) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          _indicationBloc.add(GetIndication());
                        },
                        child: Icon(
                          Icons.chevron_left,
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detail gejala",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Gejala penyakit tanaman tembakau",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Image.network(
                            "http://sipakartembakau.000webhostapp.com/assets/images/${state.data.gambar}",
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
                                state.data.namaGejala,
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
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  state.data.idGejala,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Gejala tembakau',
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
                            child: Text(state.data.keterangan),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _indicationBloc.add(GetIndication());
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
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
        ),
      ),
    );
  }

  Future<void> refresh() async {
    _indicationBloc.add(GetIndication());
  }

  _listDataIndication(IndicationGetAll state) {
    return RefreshIndicator(
      onRefresh: () {
        return refresh();
      },
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      offset: Offset(0, 2),
                      color: Colors.black.withOpacity(0.2))
                ]),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.bug_report,
                        color: Colors.black,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Gejala Penyakit",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              )),
                          Text(
                            "Daftar gejala penyakit tanaman tembakau",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          _indicationBloc.add(GetIndicationById(
                              idgejala: state.data[index].idGejala));
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            "http://sipakartembakau.000webhostapp.com/assets/images/${state.data[index].gambar}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // primary: false,
              // controller: ScrollController(keepScrollOffset: false),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                  child: InkWell(
                    onTap: () {
                      _indicationBloc.add(GetIndicationById(
                          idgejala: state.data[index].idGejala));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              color: Colors.grey[200],
                              height: 90,
                              child: Image.network(
                                "http://sipakartembakau.000webhostapp.com/assets/images/${state.data[index].gambar}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(state.data[index].namaGejala,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    state.data[index].keterangan,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(),
                                      Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "Selengkapnya",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              Icon(Icons.chevron_right,
                                                  size: 12, color: Colors.white)
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _shimmerEffect(BuildContext context) {
  return SafeArea(
    child: Shimmer.fromColors(
      highlightColor: Colors.grey[100],
      baseColor: Colors.grey[300],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            height: 90,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 25,
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 20,
                                margin: EdgeInsets.only(bottom: 5, right: 10),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 60),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

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
        child: SafeArea(
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
      ),
    );
  }

  Container _detailDataIndication(IndicationById state) {
    return Container(
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
                        "Detail Tobacco Identication",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Detail of identication tobacco",
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
                              state.data.namaGejala,
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
                      Text("Back")
                    ]),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  _listDataIndication(IndicationGetAll state) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              height: 150,
              decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue[900],
                Colors.blue[400],
              ],
            ),
          ),
              child: Container(
                padding: EdgeInsets.only(top:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.bug_report,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Tobacco Identication",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                        Text(
                          "List of identication tobacco",
                          style: TextStyle(fontSize: 12 ,color: Colors.white,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:100),
              width: MediaQuery.of(context).size.width,
              height: 110,
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
                          child: Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              "http://192.168.43.206/sipakar/${state.data[index].gambar}",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      )),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            controller: ScrollController(keepScrollOffset: false),
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
                              "http://192.168.43.206/sipakar/${state.data[index].gambar}",
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
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Tobacco disease",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.green[800],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Read more",
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
    );
  }
}

Widget _shimmerEffect(BuildContext context) {
  return Shimmer.fromColors(
    highlightColor: Colors.grey[100],
    baseColor: Colors.grey[300],
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            height: 30,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(5)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5, left: 5, right: 20),
            height: 20,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(5)),
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
  );
}

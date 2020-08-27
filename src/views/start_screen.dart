import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipakar_apps/src/blocs/indication_bloc/indication_bloc.dart';
import 'package:sipakar_apps/src/models/identification.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List<String> selectedItemValue = List<String>();
  List<String> persen = [
    '0',
    '5',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '55',
    '60',
    '65',
    '75',
    '80',
    '85',
    '90',
    '100'
  ];
  IndicationBloc _indicationBloc = IndicationBloc();
  // IdentificationBloc _identificationBloc = IdentificationBloc();

  @override
  void initState() {
    for (int i = 0; i < 17; i++) {
      selectedItemValue.add("0");
    }
    print(selectedItemValue);
    _indicationBloc = BlocProvider.of<IndicationBloc>(context);
    _indicationBloc.add(GetIndication());

    super.initState();
  }

  void _onCategorySelected(bool selected, categoryId, index, String value) {
    if (selected == true) {
      selectedItemValue[index] = value;
      setState(() {
        print(selectedItemValue);
      });
    } else {
      selectedItemValue[index] = '0';
      setState(() {
        print(selectedItemValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IndicationBloc, IndicationState>(
      bloc: _indicationBloc,
      listener: (BuildContext context, state) {
        if (state is IdentificationResultFalse) {
          Flushbar(
            title: "Mohon maaf",
            message: state.message[0]['message'],
            duration: Duration(seconds: 4),
          )..show(context);
          _indicationBloc.add(GetIndication());
        }
      },
      child: Scaffold(
        body: BlocBuilder<IndicationBloc, IndicationState>(
            bloc: _indicationBloc,
            builder: (context, state) {
              if (state is IndicationWaiting) {
                return Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: Center(child: CircularProgressIndicator()));
              }
              if (state is IndicationGetAll) {
                return _getlistIndication(context, state);
              }
              if (state is IdentificationResult) {
                return _identificationResult(state);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Scaffold _getlistIndication(BuildContext context, IndicationGetAll state) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Flushbar(
                  message:
                      "Pilih salah satu gejala lalu masukkan berat serangan gejala tersebut, Tekan mulai identifikasi untuk mengetahui persentase penyakit tanaman tembakau",
                  duration: Duration(seconds: 2),
                ).show(context);
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(
                    Icons.help_outline,
                    color: Colors.white,
                  )),
            )
          ],
          backgroundColor: Colors.blue[800],
          title: Text('Pilih Gejala'),
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.only(bottom: 100),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.data[index].namaGejala),
                  leading: Checkbox(
                    value: selectedItemValue[index] == '0' ? false : true,
                    onChanged: (bool selected) {
                      _onCategorySelected(
                          selected, state.data[index].idGejala, index, '90');
                    },
                  ),
                  trailing: DropdownButton(
                    value: selectedItemValue[index],
                    // value: '0',
                    items: persen.map((val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text('$val%'),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      selectedItemValue[index] = value;
                      value == '0'
                          ? _onCategorySelected(
                              false, state.data[index].idGejala, index, '0')
                          : _onCategorySelected(
                              true, state.data[index].idGejala, index, value);

                      setState(() {});
                    },
                  ),
                );
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blue[900],
                          Colors.blue[400],
                        ],
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          IdentificationModel identificationModel =
                              new IdentificationModel(
                            email: 'user',
                            gejala1: selectedItemValue[0],
                            gejala2: selectedItemValue[1],
                            gejala3: selectedItemValue[2],
                            gejala4: selectedItemValue[3],
                            gejala5: selectedItemValue[4],
                            gejala6: selectedItemValue[5],
                            gejala7: selectedItemValue[6],
                            gejala8: selectedItemValue[7],
                            gejala9: selectedItemValue[8],
                            gejala10: selectedItemValue[9],
                            gejala11: selectedItemValue[10],
                            gejala12: selectedItemValue[11],
                            gejala13: selectedItemValue[12],
                            gejala14: selectedItemValue[13],
                            gejala15: selectedItemValue[14],
                            gejala16: selectedItemValue[15],
                            gejala17: selectedItemValue[16],
                          );
                          _indicationBloc.add(GetIdentificationResult(
                              identificationModel: identificationModel));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Mulai Identifikasi",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Scaffold _identificationResult(IdentificationResult state) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: 150,
              width: double.infinity,
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Colors.blueAccent,
              ),
              child: Text('Hasil Identifikasi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600))),
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 75, bottom: 70),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(5),
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  if (state.result[index]['status'] == 1) {
                    return Card(
                      elevation: 3,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        state.result[index]['penyakit']
                                                ['nama_penyakit']
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                          'hasil cf = ${state.result[index]['cf_hasil'].toString()}'),
                                      Text(
                                          'Persentase : ${state.result[index]['persentase'].toString()}'),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      '${state.result[index]['persentase'].toString()}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Container(
                                child: Text('Penanganan :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                margin: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              child:
                                  Text('${state.result[index]['penanganan']}'),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _indicationBloc.add(GetIndication());
                },
                child: Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        size: 15,
                        color: Colors.white,
                      ),
                      Text(' Kembali',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

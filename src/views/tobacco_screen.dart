import 'package:flutter/material.dart';

class TobaccoScreen extends StatefulWidget {
  @override
  _TobaccoScreenState createState() => _TobaccoScreenState();
}

class _TobaccoScreenState extends State<TobaccoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.spa,
                  color: Colors.green,
                  size: 40,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    children: <Widget>[
                      Text('Virginia Tobacco',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.green)),
                      Text('Information about tobacco',
                          style: TextStyle(
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: Card(
                          elevation: 2,
                          child:
                              Container(height: 120, color: Colors.grey[200]))),
                  Flexible(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Nama',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    ' : Virginia Tobacco',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Spesies',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    ' : Aldebaran',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Founder',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    ' : Mr. Tobacco',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Class',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    ' : Tobacconicae',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Year',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    ' : 2016',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tobacco Detail :',
                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Lorem ipsum dolor Isu aje mahenka Mojolali izoe ando maror keke dolor ismo antonio hanoroko binaraga sasnowato andio malarangneng isson noloo nolosri bajuli andinoieerjj"),
                    ),
                  )
                ]),
          ),
          
          Container(
            child: SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Card(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical:10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tobacco Speciess :',
                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Lorem ipsum dolor Isu aje mahenka Mojolali izoe ando maror keke dolor ismo antonio hanoroko binaraga sasnowato andio malarangneng isson noloo nolosri bajuli andinoieerjj"),
                    ),
                  )
                ]),
          ),
        ],
      ),
    )));
  }
}

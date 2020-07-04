import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List _selecteCategorys = List();
  List<String> selectedItemValue = List<String>();
  List<String> persen = ['0', '10', '20', '90','100'];

  Map<String, dynamic> _categories = {
    "responseCode": "1",
    "responseText": "List categories.",
    "responseBody": [
      {"category_id": "1", "category_name": "Daun berlubang"},
      {"category_id": "2", "category_name": "Daun Menguning"},
      {"category_id": "3", "category_name": "Akar tanaman patah"},
      {"category_id": "4", "category_name": "Batang layu"},
      {"category_id": "5", "category_name": "Daun layu sebagian"},
      {"category_id": "6", "category_name": "Daun mendadak mati"},
      {"category_id": "7", "category_name": "Tanaman seperti terbakar"},
      {"category_id": "8", "category_name": "Akar muncul cairan"},
    ],
    "responseTotalResult":
        8 // Total result is 3 here becasue we have 3 categories in responseBody.
  };
  @override
  void initState() {
    for (int i = 0; i < _categories['responseTotalResult']; i++) {
                selectedItemValue.add("0");
              }
              print(selectedItemValue);
    super.initState();
  }

  void _onCategorySelected(bool selected, categoryId, index, String value) {
    if (selected == true) {
      selectedItemValue[index] = value;
      setState(() {
        _selecteCategorys.add(categoryId);
        // print(index);
        // print(
            // 'Masuk selected true Id $categoryId kondisi : ${_selecteCategorys.contains(categoryId)}');
            // 'Dropdown Value ${index.toString()} isinya $value');
            print(selectedItemValue);
      });
    } else {
      selectedItemValue[index] = '0';
      setState(() {
        _selecteCategorys.remove(categoryId);
        // print(
            // 'Masuk selected false Id $categoryId kondisi : ${_selecteCategorys.contains(categoryId)}');
            // 'Dropdown Index ${index.toString()} isinya $value');
            print(selectedItemValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Flushbar(
                title: "Hey Ninja",
                message:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                duration: Duration(seconds: 2),
              )..show(context);
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
        title: Text('Choose Indication'),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.only(bottom: 100),
            itemCount: _categories['responseTotalResult'],
            itemBuilder: (context, index) {
              
              
              // print(selectedItemValue);
              return ListTile(
                title:
                    Text(_categories['responseBody'][index]['category_name']),
                subtitle: Text('This is energy'),
                leading: Checkbox(
                  value: selectedItemValue[index] == '0' ? false : true,
                  // value: _selecteCategorys.contains(
                  //     _categories['responseBody'][index]['category_id']),
                  onChanged: (bool selected) {
                    _onCategorySelected(
                        selected,
                        _categories['responseBody'][index]['category_id'],
                        index,
                        '90');
                  },
                ),
                trailing: DropdownButton(
                  value: selectedItemValue[index],
                  // value: '0',
                  items: persen.map((val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text('%$val'),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    selectedItemValue[index] = value;
                    value == '0'
                        ? _onCategorySelected(
                            false,
                            _categories['responseBody'][index]['category_id'],
                            index,
                            '0')
                        : _onCategorySelected(
                            true,
                            _categories['responseBody'][index]['category_id'],
                            index,
                            value);

                    setState(() {});
                  },
                ),
              );
            },
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        ConfirmAlertBox(
                          buttonColorForYes: Colors.grey[200],
                          buttonColorForNo: Colors.grey[200],
                              title: "All data input",
                              infoMessage: '${selectedItemValue[0]}\n${selectedItemValue[1]}\n${selectedItemValue[2]}\n${selectedItemValue[3]}\n${selectedItemValue[4]}\n${selectedItemValue[5]}\n${selectedItemValue[6]}\n${selectedItemValue[7]}',
                              context: context,
                              onPressedYes: () {
                                
                              });
                      // print(selectedItemValue);
                      // print(selectedItemValue[2]);
                        // for (var i = 0; i < _categories['responseTotalResult']; i++) {
                        //   print(selectedItemValue[i]);
                        // }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
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
                          borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(60),
                              topRight: Radius.circular(100)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Start Identification",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: <Widget>[
                                Text("Found plant disease",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Flexible(flex: 1, child: Container())
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue[800],
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.help_outline,
      //     color: Colors.white,
      //     size: 40,
      //   ),
      // ),
    );
  }
}

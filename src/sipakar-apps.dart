import 'package:flutter/material.dart';
import 'package:sipakar_apps/src/models/auth-model.dart';
import 'package:sipakar_apps/src/views/account/account_screen.dart';
import 'package:sipakar_apps/src/views/auth/login_screen.dart';
import 'package:sipakar_apps/src/views/home_screen.dart';
import 'package:sipakar_apps/src/views/indication_screen.dart';
import 'package:sipakar_apps/src/views/tobacco_screen.dart';


class SipakarApps extends StatefulWidget {
  SipakarApps({Key key}) : super(key: key);

  @override
  _SipakarAppsState createState() => _SipakarAppsState();
}

class _SipakarAppsState extends State<SipakarApps> {
  int _selectedIndex = 0;
  AuthCache _authCache = AuthCache();

  //check shared preference login
  var value;
  getPref() async {
    value = await _authCache.getPref();
    setState(() {
      if (value != 1) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    IndicationScreen(),
    TobaccoScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 81, 158, 1),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, size: 18,),
            title: Text('Beranda', style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report, size: 20,),
            title: Text('Gejala', style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa, size: 18,),
            title: Text('Tembakau', style: TextStyle(fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity, size: 18,),
            title: Text('Akun', style: TextStyle(fontSize: 12),),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(38, 81, 158, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}

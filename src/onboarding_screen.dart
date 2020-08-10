import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sipakar_apps/src/views/auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage : 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive){
    return AnimatedContainer(
        duration : Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: 8.0,
        width: isActive ? 24.0 : 16.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xFF7B51D3),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.25,0.5, 0.75, 1],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0)
              ],
            )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical:40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Colors.white,fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  height: 500.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page){
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/gambar1.png'
                                ),
                                height: 300.0,
                                width: 300.0,
                              )
                            ),
                            Text(
                              'Selamat Datang di Sipakar', 
                              style: TextStyle(color: Colors.white,fontSize: 30.0),
                            ),
                            SizedBox(height: 15.0,),
                            Text(
                              'Sistem Pakar identifikasi penyakit tanaman tembaku kasturi voor-ooggt.',
                              style: TextStyle(color: Colors.white)
                            )
                          ],
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/gambar2.png'
                                ),
                                height: 300.0,
                                width: 300.0,
                              )
                            ),
                            Text(
                              'Tembakau anda terserang penyakit?', 
                              style: TextStyle(color: Colors.white,fontSize: 30.0),
                            ),
                            SizedBox(height: 15.0,),
                            Text(
                              'Kenali penyakit tanaman tembakau, agar cepat melakukan penanganan.',
                              style: TextStyle(color: Colors.white)
                            )
                          ],
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/gambar1.png'
                                ),
                                height: 300.0,
                                width: 300.0,
                              )
                            ),
                            Text(
                              'Tunggu apa lagi?', 
                              style: TextStyle(color: Colors.white,fontSize: 30.0),
                            ),
                            SizedBox(height: 15.0,),
                            Text(
                              'Yuk Mulai identifikasi penyakit tanaman tembakau sekarang juga.',
                              style: TextStyle(color: Colors.white)
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                  ? Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: (){
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500), 
                            curve: Curves.ease
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Next',style: TextStyle(color: Colors.white, fontSize: 22.0)),
                            SizedBox(height: 10.0,),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Text(''),
              ],
            )
          )
        ),
      ),
      bottomSheet: _currentPage == _numPages -1
      ? Container(
        height: 40.0,
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Center(
            child: Padding(
              padding : EdgeInsets.only(bottom:5.0, top: 5.0),
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Color(0xFF5B16D0),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
          ),
        ),
      )
      : Text(''),
    );
  }
}
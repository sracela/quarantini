import 'dart:async';

import 'package:quarantini/screens/login/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _onShowLogin);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onShowLogin() {
    if(mounted){
      Navigator.of(context).pushReplacement(LoginScreen.route());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100.0),

            Flexible(
              flex: 3,
              child: SafeArea(
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Image.asset('assets/quarantini_logo.jpg'),
                ),
              ),
            ),
//            Flexible(
//              flex: 3,
//              child: SafeArea(
//                child: Container(
//                  padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 16.0),
//                  alignment: Alignment.bottomCenter,
//                  child: CircularProgressIndicator(
//                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                  ),
//                ),
//              ),
//            ),
          ],
        )
    );
  }

}
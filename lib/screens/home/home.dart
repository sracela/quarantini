import 'package:flutter/material.dart';
import 'package:quarantini/screens/home/components/Body.dart';
import 'package:quarantini/screens/splash/splash.dart';

class MyHomePage extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => MyHomePage(),
    );
  }

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //String imageUrl = 'assets/covid1.jpg';


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SplashScreen(),
                ));},
          ),
          title: new Text("Let's play Quarantini!",
              style: Theme.of(context).textTheme.headline6),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/quarantini_logo.jpg',
                  height: 45.0,
                  width: 45.0,
                ))
          ],
        ),
        body: Body(),
        );
  }
}

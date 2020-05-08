import 'package:flutter/material.dart';

import 'CardStack.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quarantini',
      theme: ThemeData(
        fontFamily: ('RobotoMono')
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  String imageUrl = 'assets/covid1.jpg';

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {},
            ),
            title: new Text("Let's play Quarantini!",
                style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                    color: Colors.black)
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/quarantini_logo.jpg', height: 45.0,width: 45.0,)
                /*child: FlutterLogo(
                    colors: Colors.blue,
                    size: 40.0
                ),*/
              )
            ],
          ),
          body: CardStack(
                  onCardChanged: (url) {
                    setState(() {
                      imageUrl = url;
                    });
                  },
                )
        );

      }

  }





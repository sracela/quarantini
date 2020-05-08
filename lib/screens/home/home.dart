import 'package:flutter/material.dart';
import 'package:quarantini/screens/home/components/MoveCardsButtons.dart';
import 'package:quarantini/screens/home/components/Body.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String imageUrl = 'assets/covid1.jpg';
  @override
  void initState() {
    super.initState();
  }

  //final Body onCardChange;
//  void onCardChanged() {
//    setState(() {
//      _widgetIndex =
//          _widgetIndex < cards.length - 1 ? _widgetIndex + 1 : _widgetIndex;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {},
          ),
          title: new Text("Let's play Quarantini!",
              style: Theme.of(context).textTheme.title),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 50.0),
              child: Body(),
            ),
            MoveCardsButtons(),
          ],
        )
//        body: CardStack(
//          onCardChanged: (url) {
//            setState(() {
//              imageUrl = url;
//            });
//          },
//        )
        );
  }
}

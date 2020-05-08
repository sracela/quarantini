import 'package:flutter/material.dart';

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

  Animation cardAnimation, delayedCardAnimation, nextButtonAnimation, infoAnimation;
  AnimationController controller;

  // image carroussel
  int photoIndex = 0;
  List<String> photos = [
    'assets/covid1.jpg',
    'assets/covid2.jpg',
    'assets/covid3.jpg',
    'assets/covid4.jpg',
    'assets/covid5.jpg'
  ];

  void _previousImage(){
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage(){
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  //image carroussel

  @override
  void initState(){
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    cardAnimation = Tween(begin: 0.0, end: -0.025).animate(
      CurvedAnimation(
          parent: controller, curve: Curves.fastOutSlowIn)
    );
    delayedCardAnimation = Tween(begin: 0.0, end: -0.05).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    nextButtonAnimation = Tween(begin: 1.0, end: -0.010).animate(
        CurvedAnimation(
            parent:controller, curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    infoAnimation = Tween(begin: 0.0, end: 0.010).animate(
        CurvedAnimation(
            parent:controller, curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));




  }
  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    controller.forward();

    return new AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child){
        return Scaffold(
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      left: 20.0,
                      child: Container(
                        transform: Matrix4.translationValues(0.0, delayedCardAnimation.value * devHeight, 0.0),
                        width: 260.0,
                        height: 400.0,
                        decoration: BoxDecoration(
                            color: Colors.indigo[200],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      child: Container(
                        transform: Matrix4.translationValues(0.0, cardAnimation.value * devHeight, 0.0),
                        width: 280.0,
                        height: 400.0,
                        decoration: BoxDecoration(
                            color: Colors.indigo[300],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      width: 300.0,
                      height: 400.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: AssetImage(photos[photoIndex]),
                              fit: BoxFit.cover)
                      ),
                    ),
                    Positioned(
                        top: 270.0,
                        left: 15.0,
                        child: Container(
                          transform: Matrix4.translationValues(0.0, infoAnimation.value * devHeight, 0.0),
                          width: 270.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1.0,
                                    color: Colors.black12,
                                    spreadRadius: 2.0
                                )
                              ]
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Text(
                                              'Whatever bleh bleh bleh bleh bleh bleh bleh bleh bleh bleh bleh bleh ',
                                              style: TextStyle(fontSize: 20.0, color: Colors.grey)
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, nextButtonAnimation.value * devHeight, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _previousImage,
                      child: Icon(
                          Icons.close,
                          color: Colors.black
                      ),
                      backgroundColor: Colors.white,
                      splashColor: Colors.red
                    ),
                    FloatingActionButton(
                      onPressed: _nextImage,
                      child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.black
                      ),
                      backgroundColor: Colors.white,
                      splashColor: Colors.green,
                    ),
                  ],
                ),
              )
            ],
          ),
        );

      }
    );

  }
}

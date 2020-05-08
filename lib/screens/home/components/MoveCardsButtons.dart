import 'package:flutter/material.dart';
import 'Body.dart';

class MoveCardsButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //transform: Matrix4.translationValues(0.0, nextButtonAnimation.value * devHeight, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.refresh, color: Colors.black),
              backgroundColor: Colors.white,
              splashColor: Colors.red),
          FloatingActionButton(
            //onPressed: _nextImage,
            onPressed: () {},
            child: Icon(Icons.arrow_forward, color: Colors.black),
            backgroundColor: Colors.white,
            splashColor: Colors.green,
          ),
        ],
      ),
    );
  }

}

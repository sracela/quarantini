import 'package:flutter/material.dart';

class MoveCardsButtons extends StatelessWidget {

  final Function nextImage;

  MoveCardsButtons({Key key, this.nextImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FloatingActionButton(
            onPressed: nextImage,
            child: Icon(Icons.check, color: Colors.black),
            backgroundColor: Colors.white,
            splashColor: Colors.teal[200],
        ),
      ),
    );
  }

}

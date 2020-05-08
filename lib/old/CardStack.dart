import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CovidCard.dart';

Future<CardList> fetchCards() async {
  // final response = await http.get('http://127.0.0.1:8000/cards/');
  final response = await http.get('http://10.0.2.2:8000/cards');

  if (response.statusCode == 200) {
    final jsonresponse = json.decode(response.body);
    return CardList.fromJson(jsonresponse);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    var a = response.statusCode;
    throw Exception('Failed to load album. Error $a');
  }
}

class CardStack extends StatefulWidget {
  final Function onCardChanged;

  CardStack({this.onCardChanged});

  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack>
    with SingleTickerProviderStateMixin {

  Future<CardList> futureCards;

  var cards = [];

  int currentIndex;
  AnimationController controller;
  CurvedAnimation curvedAnimation;
  Animation<Offset> _translationAnim;
  Animation<Offset> _moveAnim;
  Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    futureCards = fetchCards();

    currentIndex = 1;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);

    _translationAnim = Tween(begin: Offset(0.0, 0.0), end: Offset(-1000.0, 0.0))
        .animate(controller)
          ..addListener(() {
            setState(() {});
          });

    _scaleAnim = Tween(begin: 0.965, end: 1.0).animate(curvedAnimation);
    _moveAnim = Tween(begin: Offset(0.0, 0.05), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        var commentWidgets = List<Widget>();
        if (projectSnap.hasData == null || projectSnap.hasError) {
          return Text('project snapshot data is: ${projectSnap.data}');
        } else {
          cards = projectSnap.data.cards;

//          for (var card in cards) {
//            commentWidgets.add(card); //
//          };
          commentWidgets =
              cards.reversed.map((card) {
            if (cards.indexOf(card) <= 2) {
              return GestureDetector(
                onHorizontalDragEnd: _horizontalDragEnd,
                child: Transform.translate(
                  offset: _getFlickTransformOffset(card),
                  child: FractionalTranslation(
                    translation: _getStackedCardOffset(card),
                    child: Transform.scale(
                      scale: _getStackedCardScale(card),
                      child: Center(child: card),
                    ),
                  ),
                ),
              );
            } else{
              return Container();
            }
          }).toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 50.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: commentWidgets,
                ),
              ),
              Container(
                //transform: Matrix4.translationValues(0.0, nextButtonAnimation.value * devHeight, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.close, color: Colors.black),
                        backgroundColor: Colors.white,
                        splashColor: Colors.red),
                    FloatingActionButton(
                      onPressed: _nextImage,
                      child:
                          Icon(Icons.check_circle_outline, color: Colors.black),
                      backgroundColor: Colors.white,
                      splashColor: Colors.green,
                    ),
                  ],
                ),
              )
            ],
          );
        }
      },
      future: futureCards,
    );
  }

  Offset _getStackedCardOffset(CovidCard card) {
    int diff = card.index - currentIndex;
    if (card.index == currentIndex + 1) {
      return _moveAnim.value;
    } else if (diff > 0 && diff <= 2) {
      return Offset(0.0, 0.05 * diff);
    } else {
      return Offset(0.0, 0.0);
    }
  }

  double _getStackedCardScale(CovidCard card) {
    int diff = card.index - currentIndex;
    if (card.index == currentIndex) {
      return 1.0;
    } else if (card.index == currentIndex + 1) {
      return _scaleAnim.value;
    } else {
      return (1 - (0.035 * diff.abs()));
    }
  }

  Offset _getFlickTransformOffset(CovidCard card) {
    if (card.index == currentIndex) {
      return _translationAnim.value;
    }
    return Offset(0.0, 0.0);
  }

  void _nextImage() {
    setState(() {
      controller.reset();
      CovidCard removedCard = cards.removeAt(0);
      cards.add(removedCard);
      currentIndex = cards[0].index;
      if (widget.onCardChanged != null) widget.onCardChanged(cards[0].imageUrl);
    });
  }

  void _horizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity < 0) {
      // Swiped Right to Left
      controller.forward().whenComplete(() {
        setState(() {
          controller.reset();
          CovidCard removedCard = cards.removeAt(0);
          cards.add(removedCard);
          currentIndex = cards[0].index;
          if (widget.onCardChanged != null)
            widget.onCardChanged(cards[0].imageUrl);
        });
      });
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/CardStack.dart';
import '../../../models/CovidCard.dart';
import 'package:quarantini/screens/home/components/MoveCardsButtons.dart';

Future<CardStack> fetchCards() async {
  // final response = await http.get('http://127.0.0.1:8000/cards/');
  //final response = await http.get('http://10.0.2.2:8000/cards');
  final response = await http.get('http://sracela.pythonanywhere.com/cards/');

  if (response.statusCode == 200) {
    final jsonresponse = json.decode(response.body);
    return CardStack.fromJson(jsonresponse);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    var a = response.statusCode;
    throw Exception('Failed to load cards. Error $a');
  }
}

class Body extends StatefulWidget {
  Body();
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  Future<CardStack> futureCards;
  var cards = [];
  int currentIndex;
  var commentWidgets = List<Widget>();

  AnimationController controller;
  CurvedAnimation curvedAnimation;
  Animation<Offset> _translationAnim;
  Animation<Offset> _moveAnim;
  Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    futureCards = fetchCards();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
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
        future: futureCards,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cards = snapshot.data.cards;
            currentIndex = cards[0].index;
            commentWidgets = cards.reversed.map((card) {
              if (cards.indexOf(card) <= 2) {
                return GestureDetector(
                  onHorizontalDragEnd: _horizontalDragEnd,
                  child: Transform.translate(
                    offset: _getFlickTransformOffset(card),
                    child: FractionalTranslation(
                      translation: _getStackedCardOffset(card),
                      child: Transform.scale(
                        scale: _getStackedCardScale(card),
                        child: Center( child: card),
                      ),
                    ),
                  ),
                );
//                  }
              }
              return Container();
            }).toList();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 50.0),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: commentWidgets,
                  ),
                ),
                Container(
                  child: MoveCardsButtons(nextImage: () {
                    // Swiped Right to Left
                    controller.forward().whenComplete(() {
                      setState(() {
                        controller.reset();
                        CovidCard removedCard = cards.removeAt(0);
                        cards.add(removedCard);
                        currentIndex = cards[0].index;
                      });
                    });
                  }),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
//      );
  }

  Offset _getStackedCardOffset(CovidCard card) {
    int diff = card.index - currentIndex;
    if (card.index == currentIndex+1) {
      return _moveAnim.value;
    } else if (diff > 0 && diff <= 2) {
      return Offset(0.0, 0.05 * diff);
    } else {
      return Offset(0.0, 0.0);
    }
  }

  double _getStackedCardScale(CovidCard card) {
    //int diff = card.index - currentIndex;
    if (card.index == currentIndex) {
      return 1.0;
    } else if (card.index == currentIndex + 1) {
      return _scaleAnim.value;
    } else {
      //return (1 - (0.035 * diff.abs()));
      return (1 - (0.035 * 2));
    }
  }

  Offset _getFlickTransformOffset(CovidCard card) {
    if (card.index == currentIndex) {
      return _translationAnim.value;
    }
    return Offset(0.0, 0.0);
  }

  void _horizontalDragEnd(DragEndDetails details) {
    //if (details.primaryVelocity < 0) {
    // Swiped Right to Left
    controller.forward().whenComplete(() {
      setState(() {
        controller.reset();
        CovidCard removedCard = cards.removeAt(0);
        cards.add(removedCard);
        currentIndex = cards[0].index;
//          if (widget.onCardChanged != null)
//            widget.onCardChanged(cards[0].imageUrl);
      });
    });
    //}
  }
}

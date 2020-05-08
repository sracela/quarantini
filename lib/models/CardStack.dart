import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CovidCard.dart';

class CardStack{
  //final List<CovidCard> cards;

  final cards;

  CardStack({
    this.cards,
  });

  factory CardStack.fromJson(List<dynamic> parsedJson) {
    //List<CovidCard> cards = new List<CovidCard>();
    var cards = [];
    //cards = parsedJson.map((i) => CovidCard.fromJson(i)).toList();
    cards = parsedJson.map((i)=>CovidCard.fromJson(i)).toList();
    return new CardStack(
      cards: cards,
    );
  }
  int nextImage() {
      CovidCard removedCard = cards.removeAt(0);
      cards.add(removedCard);
      int currentIndex = cards[0].index;
      return currentIndex;
      //if (widget.onCardChanged != null) widget.onCardChanged(cards[0].imageUrl);
  }


//  @override
//  Widget build(BuildContext context) {
////    return Flexible(
////            child:
////            ListView.builder(
////              itemCount: cards.length,
////              itemBuilder: (context, index){
////                return cards[index];
////              },
////            )
////    );
//    var _widgetIndex = 0;
//
//  return IndexedStack(
//    //overflow: Overflow.visible,
//    index: _widgetIndex,
//    children: cards,
//  );
//  }
}



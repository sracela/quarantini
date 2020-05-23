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

}



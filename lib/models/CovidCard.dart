import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CovidCard extends StatelessWidget {
  final int index;
  final String imageUrl;
  final String cardText;
  Widget imageCell;

  CovidCard({this.index, this.imageUrl, this.cardText});

  factory CovidCard.fromJson(Map<String, dynamic> json) {
    return CovidCard(
      index: json['id'],
      imageUrl: json['image_url'],
      cardText: json['description'],
    );
  }
//
//  Widget _imageCell(String imageUrl) {
//    return FadeInImage.memoryNetwork(
//          placeholder: kTransparentImage,
//          image: imageUrl,
//          fit: BoxFit.cover,
//        );
//  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
//        Container(
//        width: 300.0,
//        height: 400.0,
////        decoration: BoxDecoration(
////            borderRadius: BorderRadius.circular(10.0),
////            image: DecorationImage(
////                image: Image.network(imageUrl),
////                fit: BoxFit.cover)
////        ),
//        child: ClipRRect(
//            borderRadius: BorderRadius.circular(10.0),
//            child: _imageCell(imageUrl))
//
//    ),
        Container(
          width: 300.0,
          height: 400.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover)
          ),

        ),
        Positioned(
          top: -10.0,
          left: -10.0,
          child: Container(
            width: 300.0,
            height: 170.0,
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
                                cardText,
                                style: TextStyle(fontSize: 20.0, color: Colors.grey),
                            )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ),
        ),

      ],


    );
  }
}

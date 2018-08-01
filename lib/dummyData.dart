
import 'package:flutter/material.dart';

class CardData{
  final String cardTitle;
  final String cardSubtitle;
  final String cardImageUrl;
  final List<Color> gradientColors;
  final String paragraph;
  final List<String> footerImages;

  CardData({
    this.cardImageUrl = '',
    this.gradientColors = const [],
    this.cardSubtitle = '',
    this.cardTitle = '',
    this.paragraph = '',
    this.footerImages = const []
  });
}




final List<CardData> cardItems = [
  new CardData(
    cardTitle: 'COLOR',
    cardSubtitle: 'Magazines / Manifes to First N',
    cardImageUrl: 'assets/model1.jpg',
    gradientColors: [Colors.white,Colors.purpleAccent.withAlpha(100),Colors.purpleAccent.withAlpha(50)],
    paragraph: '               I thought this when i was about my childhood .it turns out that i rode the bus to school nearly 200 days a year for more',
    footerImages: ['assets/item1.jpg','assets/item2.jpg','assets/item3.jpg']
  ),
  new CardData(
      cardTitle: 'ACCENTO',
      cardSubtitle: 'Magazines / Manifes to First N',
      cardImageUrl: 'assets/gurl.jpg',
      gradientColors: [Colors.white,Colors.redAccent.withAlpha(100),Colors.redAccent.withAlpha(50)],
      paragraph: '               I thought this when i was about my childhood .it turns out that i rode the bus to school nearly 200 days a year for more',
      footerImages: ['assets/item1.jpg','assets/item2.jpg','assets/item3.jpg']
  ),

  new CardData(
      cardTitle: 'ACCENTO',
      cardSubtitle: 'Magazines / Manifes to First N',
      cardImageUrl: 'assets/gurl.jpg',
      gradientColors: [Colors.white,Colors.blueAccent.withAlpha(100),Colors.blueAccent.withAlpha(50)],
      paragraph: '               I thought this when i was about my childhood .it turns out that i rode the bus to school nearly 200 days a year for more',
      footerImages: ['assets/item1.jpg','assets/item2.jpg','assets/item3.jpg']
  ),

];
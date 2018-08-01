
import 'package:flutter/material.dart';
import 'package:xmodel_design/backBtn.dart';
import 'package:xmodel_design/details.dart';
import 'package:xmodel_design/dummyData.dart';
import 'package:xmodel_design/playBtn.dart';
import 'package:xmodel_design/text_card_container.dart';
import 'package:xmodel_design/topBackground.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  int currentActiveIndex = 0;

  int activeCardIndex(CardType cardType){
    int returnActiveIndex = 0;
    final cardItemsLength = cardItems.length - 1;
    switch(cardType){
      case CardType.centerToOffCenter:
        if(currentActiveIndex <= cardItemsLength){
          returnActiveIndex = currentActiveIndex;
        }
        break;
      case CardType.leftToRight:
        if(currentActiveIndex + 1 <= cardItemsLength){
          returnActiveIndex = currentActiveIndex + 1;
        }
        break;
      case CardType.offToRight:
        if(currentActiveIndex + 2 <= cardItemsLength){
          returnActiveIndex = currentActiveIndex + 2;
        }
        break;
    }
    return returnActiveIndex;
  }

  AnimationController animationController;

  get forward => animationController.status == AnimationStatus.forward;
  get reverse => animationController.status == AnimationStatus.reverse;
  get completed => animationController.status == AnimationStatus.completed;
  get dismissed => animationController.status == AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this,duration: const Duration(milliseconds: 700))..addListener((){
      setState(() {

      });
    })..addStatusListener((AnimationStatus status) => print(status))..forward();
  }

  onForward(){
    setState(() {
      currentActiveIndex = currentActiveIndex + 1;
    });
  }

  onReverse(){
    setState(() {
      currentActiveIndex = currentActiveIndex - 1;
    });
  }


  List<Widget> _buildScreen(){
   return forward || completed
        ? [
      CardContainerText(
        centerToOffCenterCardSubtitle: cardItems[activeCardIndex(CardType.centerToOffCenter)].cardSubtitle,
        centerToOffCenterCardTitle: cardItems[activeCardIndex(CardType.centerToOffCenter)].cardTitle,
        centerToOffCenterGradientColors: cardItems[activeCardIndex(CardType.centerToOffCenter)].gradientColors,
        leftToRightCardSwipeCardTitle: cardItems[activeCardIndex(CardType.leftToRight)].cardTitle,
        leftToRightCardSwipeGradientColors:  cardItems[activeCardIndex(CardType.leftToRight)].gradientColors,
        leftToRightCardSwipeSubtitle: cardItems[activeCardIndex(CardType.leftToRight)].cardSubtitle,
        rightEdgeCardCardSubtitle: cardItems[activeCardIndex(CardType.offToRight)].cardSubtitle,
        rightEdgeCardCardTitle: cardItems[activeCardIndex(CardType.offToRight)].cardTitle,
        rightEdgeCardGradientColors: cardItems[activeCardIndex(CardType.offToRight)].gradientColors,
        anim: animationController,
        onForward: onForward,
        onReverse: onReverse,
      ),
      TopBackground(
        anim:animationController,
        imageAssetPath:cardItems[activeCardIndex(CardType.centerToOffCenter)].cardImageUrl ,
      ),
      BackBtnText(
          anim:animationController
      ),
      PlayBtn(
          anim:animationController
      ),
      TextAndNumber(
        images: cardItems[activeCardIndex(CardType.centerToOffCenter)].footerImages,
        anim: animationController,
        text: cardItems[activeCardIndex(CardType.centerToOffCenter)].paragraph,
      )
    ]
        :[
      TopBackground(
        anim:animationController,
        imageAssetPath:cardItems[activeCardIndex(CardType.centerToOffCenter)].cardImageUrl ,
      ),
      CardContainerText(
        centerToOffCenterCardSubtitle: cardItems[activeCardIndex(CardType.centerToOffCenter)].cardSubtitle,
        centerToOffCenterCardTitle: cardItems[activeCardIndex(CardType.centerToOffCenter)].cardTitle,
        centerToOffCenterGradientColors: cardItems[activeCardIndex(CardType.centerToOffCenter)].gradientColors,
        leftToRightCardSwipeCardTitle: cardItems[activeCardIndex(CardType.leftToRight)].cardTitle,
        leftToRightCardSwipeGradientColors:  cardItems[activeCardIndex(CardType.leftToRight)].gradientColors,
        leftToRightCardSwipeSubtitle: cardItems[activeCardIndex(CardType.leftToRight)].cardSubtitle,
        rightEdgeCardCardSubtitle: cardItems[activeCardIndex(CardType.offToRight)].cardSubtitle,
        rightEdgeCardCardTitle: cardItems[activeCardIndex(CardType.offToRight)].cardTitle,
        rightEdgeCardGradientColors: cardItems[activeCardIndex(CardType.offToRight)].gradientColors,
        anim: animationController,
        onForward: onForward,
        onReverse: onReverse,
      ),
      BackBtnText(
          anim:animationController
      ),
      PlayBtn(
          anim:animationController
      ),
      TextAndNumber(
        images: cardItems[activeCardIndex(CardType.centerToOffCenter)].footerImages,
        anim: animationController,
        text: cardItems[activeCardIndex(CardType.centerToOffCenter)].paragraph,
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.play_circle_filled, color: Colors.white,),
        onPressed: (){
        if(animationController.status == AnimationStatus.completed){
          animationController.reverse();
        }else{
          animationController.forward();
        }
      }),
      body: Stack(
       children: _buildScreen()
      )
    );
  }
}




enum CardType{
  centerToOffCenter,
  leftToRight,
  offToRight
}
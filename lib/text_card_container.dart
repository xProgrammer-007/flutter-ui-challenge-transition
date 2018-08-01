import 'package:flutter/material.dart';
import 'package:xmodel_design/components/scrollCardContent.dart';

class CardContainerText extends StatefulWidget {

  final AnimationController anim;

  get forward => anim.status == AnimationStatus.forward;
  get reverse => anim.status == AnimationStatus.reverse;
  get completed => anim.status == AnimationStatus.completed;
  get dismissed => anim.status == AnimationStatus.forward;

  final Function() onForward;
  final Function() onReverse;

  final String centerToOffCenterCardTitle;
  final String centerToOffCenterCardSubtitle;
  final List<Color> centerToOffCenterGradientColors;

  final String leftToRightCardSwipeCardTitle;
  final String leftToRightCardSwipeSubtitle;
  final List<Color> leftToRightCardSwipeGradientColors;

  final String rightEdgeCardCardTitle;
  final String rightEdgeCardCardSubtitle;
  final List<Color> rightEdgeCardGradientColors;

  CardContainerText({
    this.anim,
    this.onForward,
    this.onReverse,

    this.centerToOffCenterCardSubtitle = '',
    this.centerToOffCenterCardTitle = '',
    this.centerToOffCenterGradientColors = const [],

    this.leftToRightCardSwipeCardTitle = '',
    this.leftToRightCardSwipeGradientColors = const [],
    this.leftToRightCardSwipeSubtitle = '',

    this.rightEdgeCardCardSubtitle = '',
    this.rightEdgeCardCardTitle ='',
    this.rightEdgeCardGradientColors = const [],

  });

  @override
  CardContainerTextState createState() {
    return new CardContainerTextState();
  }
}

class CardContainerTextState extends State<CardContainerText> with TickerProviderStateMixin{

  Animation<double> animatedWidth;
  Animation<double> animatedHeight;
  Animation<double> textSizeBottom;
  AnimationController cardSwipe;
  Animation<FractionalOffset> leftToRightCardSwipe;
  Animation<FractionalOffset> centerToOffCenterSwipe;
  Animation<FractionalOffset> rightEdgeCard;
  int activeCardIndex = 0;

  Offset currDrag;

  @override
  void initState() {
    super.initState();

    cardSwipe = new AnimationController(duration: const Duration(milliseconds: 600),vsync: this)..addListener((){
      setState(() {

      });
    });

    leftToRightCardSwipe = Tween(begin:FractionalOffset(0.85,0.0),end:FractionalOffset(0.0,0.0)).animate(
      new CurvedAnimation(parent: cardSwipe,curve: Interval(0.0,0.8,curve: Curves.easeOut))
    );

    rightEdgeCard = Tween(begin:FractionalOffset(1.2,0.0),end:FractionalOffset(0.85,0.0)).animate(
        new CurvedAnimation(parent: cardSwipe,curve: Interval(0.7,1.0,curve: Curves.easeOut))
    );

    centerToOffCenterSwipe = Tween(begin:FractionalOffset(0.0,0.0),end:FractionalOffset(-1.0,0.0)).animate(
        new CurvedAnimation(parent: cardSwipe,curve: Interval(0.0,0.8,curve: Curves.easeOut))
    );

    animatedHeight = Tween(begin: 270.0,end:350.0).animate(widget.anim);
    animatedWidth = Tween(begin: 200.0,end:250.0).animate(widget.anim);
    textSizeBottom = Tween(begin: 11.0,end:13.0).animate(widget.anim);
  }

  _onHorizontalDragStart(DragStartDetails details){
    currDrag = details.globalPosition;
  }

  _onHorizontalDragUpdate(DragUpdateDetails details){
    print(details.globalPosition);
    if((currDrag.dx - details.globalPosition.dx).abs() > 20.0){
      //cardSwipe.forward(from: 0.0);
      widget.onForward();
    }else if((currDrag.dx - details.globalPosition.dx).abs() < 20.0){
      cardSwipe.reverse(from: 0.0);
      //widget.onReverse();
    }
  }

  _onHorizontalDragEnd(DragEndDetails details){
    currDrag = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,

      child: Transform(
        transform: Matrix4.translationValues(-15.0,0.0,0.0),
        child: OverflowBox(
          alignment: Alignment.topCenter,
          maxWidth: double.infinity,
          child: Stack(
            children: <Widget>[

              new CardContent(
                  xAxisOffset: centerToOffCenterSwipe,
                  animatedHeight: animatedHeight,
                  widget: widget,
                  title:widget.centerToOffCenterCardTitle,
                  subTitle: widget.centerToOffCenterCardSubtitle,
                  textSizeBottom: textSizeBottom,
                  colors: widget.centerToOffCenterGradientColors,
              ),
              Opacity(
                opacity: 1.0 - widget.anim.value,
                child: new CardContent(
                    xAxisOffset: leftToRightCardSwipe,
                    animatedHeight: animatedHeight,
                    widget: widget,
                    textSizeBottom: textSizeBottom,
                    title:widget.leftToRightCardSwipeCardTitle,
                    subTitle: widget.leftToRightCardSwipeSubtitle,
                    colors: widget.leftToRightCardSwipeGradientColors,
                ),
              ),
              new CardContent(
                  xAxisOffset: rightEdgeCard,
                  animatedHeight: animatedHeight,
                  widget: widget,
                  title:widget.rightEdgeCardCardTitle,
                  subTitle: widget.rightEdgeCardCardSubtitle,
                  textSizeBottom: textSizeBottom,
                  colors:widget.rightEdgeCardGradientColors,
              ),

            ],
          ),
        ),
      ),
    );
  }
}








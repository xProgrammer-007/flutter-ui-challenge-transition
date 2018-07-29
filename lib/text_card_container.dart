import 'package:flutter/material.dart';

class CardContainerText extends StatefulWidget {

  final AnimationController anim;
  get forward => anim.status == AnimationStatus.forward;

  get reverse => anim.status == AnimationStatus.reverse;

  get completed => anim.status == AnimationStatus.completed;


  get dismissed => anim.status == AnimationStatus.forward;
  CardContainerText({this.anim});

  @override
  CardContainerTextState createState() {
    return new CardContainerTextState();
  }
}

class CardContainerTextState extends State<CardContainerText> {

  Animation<double> animatedWidth;
  Animation<double> animatedHeight;
  Animation<double> textSizeBottom;


  @override
  void initState() {
    super.initState();
    animatedHeight = Tween(begin: 270.0,end:350.0).animate(widget.anim);
    animatedWidth = Tween(begin: 200.0,end:250.0).animate(widget.anim);
    textSizeBottom = Tween(begin: 11.0,end:13.0).animate(widget.anim);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:50.0,left:20.0,right: 50.0,),
      child: Card(
        child: Container(
          height: animatedHeight.value,
          width:  250.0,//animatedWidth.value,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white,Colors.purpleAccent.withAlpha(100),Colors.purpleAccent.withAlpha(50)],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops:[0.3,0.7,1.0]
              ),

          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize:MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Transform(
                  transform: Matrix4.translationValues(
                      0.0,
                      0.0,//-50 *(1.0 - widget.anim.value),
                      0.0
                  ),
                  child: Text(
                    'COLOR',
                    style: TextStyle(
                      fontSize: 40.0 - 10 * (1.0 - widget.anim.value),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:15.0,top:15.0),
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0,
                        0.0,//-50 *(1.0 - widget.anim.value),
                        0.0
                    ),
                    child: Container(
                      color:const Color(0xFF3E3E3E),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Magazines / Manifes to First N',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: textSizeBottom.value + 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0,
                          0.0,//-50 *(1.0 - widget.anim.value),
                          0.0
                      ),
                      child: Text(
                          'Creating a `Side Projects` Culture on me',
                        style: TextStyle(
                          fontSize: textSizeBottom.value,
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class AbsoluteClipper extends CustomClipper<Rect>{
  Path path = new Path();
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}
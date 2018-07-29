import 'package:flutter/material.dart';


class BackBtnText extends StatefulWidget {
  final AnimationController anim;
  get forward => anim.status == AnimationStatus.forward;

  get reverse => anim.status == AnimationStatus.reverse;

  get completed => anim.status == AnimationStatus.completed;


  get dismissed => anim.status == AnimationStatus.forward;
  BackBtnText({this.anim});

  @override
  BackBtnTextState createState() {
    return new BackBtnTextState();
  }
}

class BackBtnTextState extends State<BackBtnText> {

  Animation<double> textPosition;
  Animation<double> iconPosition;

  @override
  void initState() {
    super.initState();
    textPosition = Tween(begin: 40.0,end:180.0).animate(
      CurvedAnimation(
        parent: widget.anim,
        curve: Interval(0.0,1.0,curve: Curves.easeInOut)
      )
    );
    iconPosition = Tween(begin: 0.0,end:15.0).animate(
        CurvedAnimation(
            parent: widget.anim,
            curve: Interval(0.5,1.0,curve: Curves.easeInOut)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10.0,
      top:textPosition.value,
      child: Opacity(
        opacity: widget.anim.value,
        child: Column(
          children: <Widget>[
            Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  iconPosition.value,
                  0.0,
                ),
                child: Icon(Icons.compare_arrows,color: Colors.white,)
            ),
            Container(
              height: 20.0,
            ),
            Text(
              'b\na\nc\nk'.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }


}

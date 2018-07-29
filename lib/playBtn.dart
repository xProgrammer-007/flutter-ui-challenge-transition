import 'package:flutter/material.dart';

class PlayBtn extends StatefulWidget {
  final AnimationController anim;
  get forward => anim.status == AnimationStatus.forward;

  get reverse => anim.status == AnimationStatus.reverse;

  get completed => anim.status == AnimationStatus.completed;


  get dismissed => anim.status == AnimationStatus.forward;


  PlayBtn({this.anim});
  @override
  PlayBtnState createState() {
    return new PlayBtnState();
  }
}

class PlayBtnState extends State<PlayBtn> {
Animation<double> position;
Animation<double> size;
Animation<double> iconSize;
Animation color;

@override
void initState() {
  super.initState();
  position = Tween(begin:60.0,end:180.0).animate(widget.anim);
  size =    Tween(begin:30.0,end:70.0).animate(widget.anim);
  iconSize =    Tween(begin:30.0,end:40.0).animate(widget.anim);
  color = ColorTween(begin: Colors.black26,end:Colors.black87).animate(widget.anim);
}

@override
  Widget build(BuildContext context) {
    return Positioned(
      top:position.value,
      left:40.0,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(5.0),
        width: size.value,
        height: size.value,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:Colors.white,
        ),
        child: RaisedButton(
          onPressed: (){},
          elevation: 3.0,
          highlightColor: Colors.black,
          splashColor: Colors.black,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(iconSize.value)),
          color:color.value,
          child: Transform(
              transform: Matrix4.translationValues(-10.0,0.0,0.0),
              child: Center(
                  child: Icon(
                    Icons.play_arrow,color: position.value > 60 && position.value < 180 ? Colors.transparent : Colors.white,size: 50.0,)
              )
          ),
        ),
      ),
    );
  }
}

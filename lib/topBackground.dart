import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class TopBackground extends StatefulWidget {
  final AnimationController anim;
  final String imageAssetPath;
  final Color bgColor;


  get forward => anim.status == AnimationStatus.forward;
  get reverse => anim.status == AnimationStatus.reverse;
  get completed => anim.status == AnimationStatus.completed;
  get dismissed => anim.status == AnimationStatus.dismissed;

  TopBackground({
    this.anim,
    this.bgColor = Colors.pink,
    this.imageAssetPath = ''
  });
  @override
  TopBackgroundState createState() {
    return new TopBackgroundState();
  }
}

class TopBackgroundState extends State<TopBackground> {
  Animation<double> imageWidth;
  Animation<double> imageHeight;


  @override
  void initState() {
    super.initState();
    imageWidth = Tween(begin: 0.0,end:250.0).animate(
      new CurvedAnimation(
        parent: widget.anim,
        curve: Interval(0.3,0.8,curve: Curves.easeInOut)
      )
    );
    imageHeight = Tween(begin: 0.0,end:270.0).animate(
        new CurvedAnimation(
            parent: widget.anim,
            curve: Interval(0.3,1.0,curve: Curves.easeInOut)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
      widget.anim.status == AnimationStatus.completed
          ? 350.0
          : widget.anim.status == AnimationStatus.forward
          ? widget.anim.value * 350
          : widget.anim.status == AnimationStatus.reverse
          ?  200.0 + (150.0 * widget.anim.value)
          : 200.0
      ,
      width: double.infinity,
      child: ClipPath(
          clipper: swordClipper(
              animationController: widget.anim
          ),
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: widget.anim.value,
                child: new Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new ExactAssetImage(widget.imageAssetPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child:Transform(
                      transform: Matrix4.translationValues(0.0, 0.0,0.0)..scale(( widget.anim.value) * 2.5,(widget.anim.value) * 2.5),
                      child: new BackdropFilter(
                        filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: new Container(
                          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                    )
                ),
              ),
              Opacity(
                opacity: 1.0 - widget.anim.value,
                child: Container(
                  color: widget.bgColor.withAlpha(100),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  transform: Matrix4.translationValues(-31.0,0.0,0.0),
                  width: imageWidth.value ,
                  height: imageHeight.value ,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 10.0,
                        offset: Offset(3.0,-1.0),
                        blurRadius: 15.0
                      )
                    ],
                      image: DecorationImage(
                          image:AssetImage(widget.imageAssetPath),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}



class shadePainter extends CustomPainter{
AnimationController animationController;
Paint shadePaint;
Path path;
shadePainter({
  this.animationController,
}): path  = new Path(), shadePaint = new Paint(){
  shadePaint
  ..style = PaintingStyle.fill
  ..strokeWidth = 10.0;
}
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0.0, (-160.0 * (animationController.value)));
    //path.addRect(Rect.fromLTWH(0.0, size.height - 10.0 , size.width,10.0));
    path.moveTo(0.0, 0.0);
    path.moveTo(0.0,size.height- 40);
    path.lineTo(size.width + 50.0, size.height + (170.0 * ( animationController.value)));
    //path.lineTo(size.width, size.height -10 * (1.0 - animationController.value));//size.height - size.height / 3.1);
    //path.lineTo(size.width, size.height * animationController.value + 10);
    path.lineTo(0.0,size.height);
    path.close();

    canvas.drawShadow(path, Colors.black87, 5.0, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}


class swordClipper extends CustomClipper<Path>{
  final AnimationController animationController;
  swordClipper({this.animationController});

  Path path = new Path();

  @override
  Path getClip(Size size) {
    path.lineTo(0.0, 0.0);
    path.moveTo(0.0,size.height - size.height/2.1 * animationController.value);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
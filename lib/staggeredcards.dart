import 'package:flutter/material.dart';

class StaggeredCards extends StatefulWidget {
  final AnimationController anim;
  final List<String> images;

  StaggeredCards({
    this.anim,
    this.images = const []
  });
  @override
  _StaggeredCardsState createState() => _StaggeredCardsState();
}

class _StaggeredCardsState extends State<StaggeredCards> {

  get forward => widget.anim.status == AnimationStatus.forward;

  get reverse => widget.anim.status == AnimationStatus.reverse;

  get completed => widget.anim.status == AnimationStatus.completed;


  get dismissed => widget.anim.status == AnimationStatus.dismissed;


  List<Widget> _buildCards(){
    final animTime = 0.5;
    final delayTime = 0.1;
    Curve cardCurve;
      int _index = 0;
      return widget.images.map((image){
        if(reverse){
          final start = delayTime * _index;
          final end = start + animTime;
          cardCurve = new Interval(start,end,curve: Curves.easeInOut);

        }else{
          final intervalStart = 1.0;

          final end = intervalStart - (delayTime * _index);
          final start = end - animTime;
          cardCurve = new Interval(start,end,curve: Curves.easeInOut);

        }
        ++_index;
        return AnimatedCard(
          duration: const Duration(milliseconds: 1000),
          curve: cardCurve,
          child: FooterCard(
            model: CardModel(
              assetPath: image,
            ),
          ),
          animStatus: widget.anim.status,
        );
      }).toList();



  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      height: 100.0 * (1.0 - widget.anim.value),
      width:double.infinity,
      child: OverflowBox(
        maxWidth: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              width: 150.0,
            )
          ]..addAll(_buildCards())
        ),
      ),
    );
  }
}


class AnimatedCard extends ImplicitlyAnimatedWidget {
  final Duration duration;
  final Curve curve ;
  final Widget child;
  final AnimationStatus animStatus;

  AnimatedCard({
    this.curve = const Interval(0.0,1.0,curve: Curves.ease),
    this.duration,
    this.child,
    this.animStatus,
  }):super(curve:curve,duration:duration);

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends AnimatedWidgetBaseState<AnimatedCard> {
 Tween<double> _translate;
 Tween<double> _height;

 double translateValue;
  double height;
 @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(_translate.evaluate(animation),0.0,0.0),
      child: Container(
          height: _height.evaluate(animation),
          width: _height.evaluate(animation),
          child: widget.child
        ),
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    switch(widget.animStatus){
      case AnimationStatus.forward:
        translateValue = 100.0;
        height = 0.0;
        break;
      case AnimationStatus.completed:
        translateValue = 200.0;
        height = 100.0;
        break;
      case AnimationStatus.reverse:
        translateValue = 0.0;
        height = 0.0;
        break;
      case AnimationStatus.dismissed:
        translateValue = 0.0;
        height = 100.0;
        break;
    }
    _translate = visitor(
      _translate,
      translateValue,
      (dynamic value) => Tween<double>(begin:value)
    );
    _height = visitor(
        _height,
        height,
            (dynamic value) => Tween<double>(begin:value)
    );
  }
}


class FooterCard extends StatelessWidget {
final CardModel model;

FooterCard({
  this.model
});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(model.assetPath,fit: BoxFit.cover,),
          ),
          Opacity(opacity:0.5,child: Image.asset('assets/shadow-overlay.png',fit: BoxFit.cover,))
        ],
      ),
    );
  }
}


class CardModel{
  final String assetPath;
  final String subtitle1;
  final String subtitle2;

  CardModel({
    this.subtitle1,
    this.assetPath,
    this.subtitle2
  });
}

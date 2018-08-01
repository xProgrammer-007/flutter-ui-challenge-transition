import 'package:flutter/material.dart';
import 'package:xmodel_design/staggeredcards.dart';

class TextAndNumber extends StatefulWidget {

  final AnimationController anim;
  final String text;
  final String dropText;
  final Color color;
  final List<String> images;
  TextAndNumber({
    this.anim,
    this.text = '',
    this.images = const [],
    this.color = Colors.purpleAccent,
    this.dropText = 'When'
  });

  @override
  TextAndNumberState createState() {
    return new TextAndNumberState();
  }
}

class TextAndNumberState extends State<TextAndNumber> {
  Animation<double> textVisible;
  Animation<double> textOffset;
  Animation<double> recommendText;


  get forward => widget.anim.status == AnimationStatus.forward;

  get reverse =>  widget.anim.status == AnimationStatus.reverse;

  get completed =>  widget.anim.status == AnimationStatus.completed;

  get dismissed => widget.anim.status == AnimationStatus.dismissed;


  @override
  void initState() {
    super.initState();
    textVisible = Tween(begin:0.0,end:1.0).animate(
      new CurvedAnimation(
        parent: widget.anim,
        curve: Interval(0.5,1.0)
      )
    );
    textOffset = Tween(begin:-80.0,end:0.0).animate(
        new CurvedAnimation(
            parent: widget.anim,
            curve: Interval(0.0,0.6,curve: Curves.easeOut)
        )
    );
    recommendText = Tween(begin:-40.0,end:0.0).animate(
        new CurvedAnimation(
            parent: widget.anim,
            curve: Interval(0.0,1.0,curve: Curves.easeInOut)
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:20.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            textOffset.value == -80.0 ? Container() :
            Transform(
              transform: Matrix4.translationValues(0.0, textOffset.value, 0.0),
              child: Opacity(
                opacity: textVisible.value,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom:10.0,left:8.0),
                      child: Text(
                        widget.text,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            height: 1.2,
                            color: Colors.black38,
                            fontSize: 16.0,
                            wordSpacing: 1.2
                        ),
                      ),
                    ),
                    Positioned(
                      left:0.0,
                      top:0.0,
                      child: Container(
                        transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.dropText,
                          style: TextStyle(
                            height: 1.1,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Transform(
              transform:Matrix4.translationValues(0.0,recommendText.value, 0.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Recommended',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),
                      ),
                      subtitle: Text(
                        'Magazines',
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),

                  Text(
                    '24',
                    style: TextStyle(
                      fontSize: 42.0,
                    ),
                  )
                ],
              ),
            ),

             dismissed || reverse || forward ? new StaggeredCards(
                images: widget.images,
                anim:widget.anim
            ) : Container(),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(
                      'MON 24  -',
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top:10.0),
                      height: 10.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          colors: [widget.color.withOpacity(0.3),Colors.white],
                          begin: FractionalOffset.centerLeft,
                          end:FractionalOffset.centerRight,
                          stops: [0.1,0.7]
                        )
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

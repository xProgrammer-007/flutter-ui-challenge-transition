import 'package:flutter/material.dart';
import 'package:xmodel_design/text_card_container.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    Key key,
    @required this.xAxisOffset,
    @required this.animatedHeight,
    @required this.widget,
    @required this.textSizeBottom,
    this.colors,
    this.subTitle = '',
    this.title = ''
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Animation<FractionalOffset> xAxisOffset;
  final Animation<double> animatedHeight;
  final CardContainerText widget;
  final Animation<double> textSizeBottom;
  final colors;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: Offset(xAxisOffset.value.dx,xAxisOffset.value.dy),
      child: Padding(
        padding: const EdgeInsets.only(top:50.0,left:20.0,right: 50.0,),
        child: Card(
          child: Container(
            height: animatedHeight.value,
            width:  250.0,//animatedWidth.value,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: colors,
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
                      title,
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
                            subTitle,
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
      ),
    );
  }
}

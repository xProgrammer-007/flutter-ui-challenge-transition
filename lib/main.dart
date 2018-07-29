
import 'package:flutter/material.dart';
import 'package:xmodel_design/backBtn.dart';
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
  AnimationController animationController;

  get forward => animationController.status == AnimationStatus.forward;

  get reverse => animationController.status == AnimationStatus.reverse;

  get completed => animationController.status == AnimationStatus.completed;


  get dismissed => animationController.status == AnimationStatus.forward;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this,duration: const Duration(milliseconds: 700))..addListener((){
      setState(() {

      });
    })..addStatusListener((AnimationStatus status) => print(status))..forward();
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
       children: forward || completed || reverse
           ? [
         CardContainerText(
           anim: animationController,
         ),
         TopBackground(
             anim:animationController
         ),
         BackBtnText(
             anim:animationController
         ),
         PlayBtn(
             anim:animationController
         )
       ]
        :[
         TopBackground(
             anim:animationController
         ),
         CardContainerText(
           anim: animationController,
         ),
         BackBtnText(
             anim:animationController
         ),
         PlayBtn(
             anim:animationController
         )
       ],
      )
    );
  }
}





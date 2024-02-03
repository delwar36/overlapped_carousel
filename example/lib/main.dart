import 'dart:math';

import 'package:overlapped_carousel/overlapped_carousel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Overlapped Carousel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Overlapped Carousel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Generate a list of widgets. You can use another way
  List<Widget> widgets = List.generate(
    10,
    (index) => ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      child: Image.asset(
        'assets/images/$index.jpg', //Images stored in assets folder
        fit: BoxFit.fill,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      //Wrap with Center to place the carousel center of the screen
      body: Center(
        //Wrap the OverlappedCarousel widget with SizedBox to fix a height. No need to specify width.
        child: SizedBox(
          height: min(screenWidth / 3.3 * (16 / 9), screenHeight * .9),
          child: OverlappedCarousel(
            widgets: widgets, //List of widgets
            currentIndex: 2,
            onClicked: (index) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("You clicked at $index"),
                ),
              );
            },
            obscure: 0.4,
            skewAngle: 0.1,
          ),
        ),
      ),
    );
  }
}

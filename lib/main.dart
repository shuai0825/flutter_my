import 'package:flutter/material.dart';
import 'package:flutter_my/views/MyHomePage.dart';

const int ThemeColor = 0xFFC91B3A;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primaryColor: Color(ThemeColor),
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

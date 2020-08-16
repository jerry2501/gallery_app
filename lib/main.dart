import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/homepage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(fontStyle: FontStyle.italic,fontFamily: 'Times new roman',fontWeight: FontWeight.bold,color: Colors.white),
        )
      ),
      home: MyHomePage(),
    );
  }
}


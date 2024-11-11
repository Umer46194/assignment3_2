// main.dart

import 'package:flutter/material.dart';
import 'package:assihnment3_2/home.dart'; // Import the HomeScreen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,

      ),
      home: Home(), // Reference HomeScreen here

    );
  }
}

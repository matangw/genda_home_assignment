import 'package:flutter/material.dart';
import 'package:genda_home_assignment/home_page/home_page_component.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genda Home Assignment',
      theme: ThemeData(
        fontFamily: 'Anton-Regular'
      ),
      home: HomePageComponent()
    );
  }
}


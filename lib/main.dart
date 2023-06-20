import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter NETFLIX CLONE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.black),
      home: NavScreen(),
    );
  }
}

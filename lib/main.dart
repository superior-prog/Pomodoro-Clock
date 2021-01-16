import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/pomodoro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      debugShowCheckedModeBanner: false,
      home: Pomodoro(),
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        accentColor: Colors.blueAccent,
        cursorColor: Colors.blueAccent,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          labelStyle: TextStyle(color: Colors.white),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
        ),
        scaffoldBackgroundColor: Colors.black,
        dividerColor: Colors.black54,
      ),
    );
  }
}

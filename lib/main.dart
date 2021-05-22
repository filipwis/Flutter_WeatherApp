import 'package:flutter/material.dart';
import 'package:flutter_weather_app/layout/screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.grey,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Lato',
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: HomeScreen(),
    );
  }
}

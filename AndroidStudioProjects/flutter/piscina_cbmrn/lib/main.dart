import 'package:flutter/material.dart';
import 'package:piscina_cbmrn/splashScreen.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Piscina CBMRN',
      home: SplashScreen(),

    );
  }

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.black,
      primaryColor: Colors.blue,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.blue,
        ),
        labelStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
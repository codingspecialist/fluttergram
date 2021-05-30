import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/material_white.dart';
import 'package:flutter_instagram/home_page.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:flutter_instagram/screens/join_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginScreen(),
        "/join": (context) => JoinScreen(),
        "/home": (context) => HomePage(),
        "/logout": (context) => LoginScreen(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
    );
  }
}

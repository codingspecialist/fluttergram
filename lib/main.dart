import 'package:flutter/material.dart';
import 'package:flutter_instagram/home_page.dart';
import 'package:flutter_instagram/screens/camera_screen.dart';
import 'package:flutter_instagram/screens/photo_screen.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:flutter_instagram/screens/join_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/home",
      routes: {
        "/login": (context) => LoginScreen(),
        "/join": (context) => JoinScreen(),
        "/home": (context) => HomePage(),
        "/photo": (context) => PhotoScreen(),
        "/camera": (context) => CameraScreen(),
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

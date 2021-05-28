import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/material_white.dart';
import 'package:flutter_instagram/home_page.dart';
import 'package:flutter_instagram/screens/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
    );
  }
}

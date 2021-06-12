import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/home_page.dart';
import 'package:flutter_instagram/models/firebase_auth_state.dart';
import 'package:flutter_instagram/screens/camera_screen.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:flutter_instagram/screens/join_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? initialScreen;
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

  Future<FirebaseApp> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app');
    return app;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeDefault(),
      builder: (context, snapshot) {
        return ChangeNotifierProvider<FirebaseAuthState>.value(
          value: _firebaseAuthState,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Consumer<FirebaseAuthState>(
              builder: (context, value, child) {
                if (!snapshot.hasData) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (value.firebaseAuthStatus == FirebaseAuthStatus.login) {
                    return HomePage();
                  } else if (value.firebaseAuthStatus ==
                      FirebaseAuthStatus.logout) {
                    return LoginScreen();
                  } else {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }
              },
            ),
            routes: {
              "/login": (context) => LoginScreen(),
              "/join": (context) => JoinScreen(),
              "/home": (context) => HomePage(),
              "/camera": (context) => CameraScreen(),
              "/logout": (context) => LoginScreen(),
            },
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/home_page.dart';
import 'package:flutter_instagram/models/user_repository.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:flutter_instagram/screens/join_screen.dart';
import 'package:flutter_instagram/widgets/common/my_progress_indicator.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserRepository>(
      create: (_) => UserRepository.instance(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<UserRepository>(
          builder: (context, user, child) {
            print("컨슈머 실행됨");
            switch (user.status) {
              case Status.Uninitialized:
              case Status.Authenticating:
                return MyProgressIndicator();
              case Status.Unauthenticated:
                return LoginScreen();
              case Status.Authenticated:
                print("HomePage");
                return HomePage();
              case Status.login:
                print("LoginScreen");
                return LoginScreen();
              case Status.join:
                print("JoinScreen");
                return JoinScreen();
            }
          },
        ),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

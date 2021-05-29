import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/sign_up_screen.dart';
import 'package:flutter_instagram/widgets/signin/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SignInForm(),
            _bottomNavigationButton(context),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationButton(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          Divider(),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SignUpScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                ),
                (route) => false,
              );
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

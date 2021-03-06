import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/user_repository.dart';
import 'package:flutter_instagram/screens/join_screen.dart';
import 'package:flutter_instagram/widgets/login/login_form.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              Provider.of<UserRepository>(context, listen: false)
                  .route("/join");
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

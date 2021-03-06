import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/user_repository.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:flutter_instagram/widgets/join/join_form.dart';
import 'package:provider/provider.dart';

class JoinScreen extends StatefulWidget {
  @override
  _JoinScreenState createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SignUpForm(),
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
                  .route("/login");
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: "Sign In",
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

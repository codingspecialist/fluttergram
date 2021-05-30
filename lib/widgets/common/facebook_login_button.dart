import 'package:flutter/material.dart';

import '../../constants/common_size.dart';

class FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: common_l_gap),
                child: Text(
                  "OR",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Expanded(child: Container(color: Colors.grey[300], height: 1)),
            ],
          ),
          SizedBox(height: common_gap),
          TextButton.icon(
            onPressed: () {},
            icon: ImageIcon(AssetImage("assets/images/facebook.png")),
            label: Text(
              "Login with Facebook",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}

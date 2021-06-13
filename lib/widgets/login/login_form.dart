import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/models/user_repository.dart';
import 'package:flutter_instagram/widgets/common/custom_blue_button.dart';
import 'package:flutter_instagram/widgets/common/custom_text_form_field.dart';
import 'package:flutter_instagram/widgets/common/facebook_login_button.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: common_l_gap),
            Image.asset("assets/images/insta_text_logo.png"),
            SizedBox(height: common_gap),
            CustomTextFormField(
              controller: _emailController,
              hintText: "Email",
              validator: (value) {
                if (value.isNotEmpty && value.contains("@")) {
                  return null;
                } else {
                  return "이메일 형식에 맞지 않습니다.";
                }
              },
            ),
            SizedBox(height: common_gap),
            CustomTextFormField(
              controller: _passwordController,
              hintText: "Password",
              isSecret: true,
              validator: (value) {
                if (value.isNotEmpty && value.length > 5) {
                  return null;
                } else {
                  return "패스워드 형식에 맞지 않습니다.";
                }
              },
            ),
            TextButton(
              onPressed: () {},
              child: Align(
                child: Text("Forgotten Password?"),
                alignment: Alignment.centerRight,
              ),
            ),
            CustomBlueButton(
              value: "Login",
              formKey: _formKey,
              authProgress: () {
                Provider.of<UserRepository>(context, listen: false).signIn(
                    _emailController.text.trim(),
                    _passwordController.text.trim());
              },
            ),
            FacebookLoginButton(),
          ],
        ),
      ),
    );
  }
}

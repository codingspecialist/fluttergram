import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required TextEditingController emailController,
  })   : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: "Email",
        fillColor: Colors.grey[150],
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(double_common_s_gap),
        ),
      ),
      validator: (value) {
        if (value!.isNotEmpty && value.contains("@")) {
          return null;
        } else {
          return "이메일 형식에 맞지 않습니다.";
        }
      },
    );
  }
}

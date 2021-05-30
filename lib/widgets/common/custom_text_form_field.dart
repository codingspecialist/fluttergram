import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.isSecret = false})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final validator;
  final bool isSecret;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: isSecret,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.grey[150],
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(double_common_s_gap),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(double_common_s_gap),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(double_common_s_gap),
          ),
        ),
        validator: validator);
  }
}

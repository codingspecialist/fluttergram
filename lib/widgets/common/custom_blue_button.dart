import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/home_page.dart';

class CustomBlueButton extends StatelessWidget {
  const CustomBlueButton({
    Key? key,
    required this.value,
    required this.formKey,
    required this.authProgress,
  }) : super(key: key);

  final String value;
  final GlobalKey<FormState>? formKey;
  final authProgress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: common_gap),
      child: SizedBox(
        height: 45,
        // null safety
        // https://www.grepiu.com/post/74
        // 조건 ? A : B; (삼항연산자)
        // a?.test(); (a가 null이 아니면 test를 실행한다)
        // a ??= b; (a가 null이면 b를 넣는다)
        // a = b ?? c; (b가 null이 아니면 a에 배정한다. 아니면 c를 배정한다)
        // 값! (값이 null 이 아니다고 확신하는 연산자)
        child: TextButton(
          onPressed: () {
            if (formKey != null) {
              if (formKey!.currentState!.validate()) {
                authProgress();
              }
            }
          },
          // 버튼 스타일 참고 : https://devmemory.tistory.com/53
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.lightBlue;
                } else {
                  return Colors.blue;
                }
              },
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

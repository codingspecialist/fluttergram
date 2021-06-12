import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/home_page.dart';

class CustomFollowButton extends StatelessWidget {
  const CustomFollowButton({
    Key? key,
    required this.value,
    required this.followingOrFollow,
  }) : super(key: key);

  final String value;
  final followingOrFollow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      // null safety
      // https://www.grepiu.com/post/74
      // 조건 ? A : B; (삼항연산자)
      // a?.test(); (a가 null이 아니면 test를 실행한다)
      // a ??= b; (a가 null이면 b를 넣는다)
      // a = b ?? c; (b가 null이 아니면 a에 배정한다. 아니면 c를 배정한다)
      // 값! (값이 null 이 아니다고 확신하는 연산자)
      child: OutlinedButton(
        onPressed: followingOrFollow,
        style: OutlinedButton.styleFrom(
            backgroundColor:
                value == "Following" ? Colors.white : Colors.blue[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          value,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

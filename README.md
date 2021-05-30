# flutter_instagram

## ButtonStyle
- https://devmemory.tistory.com/53

## null safety
- https://www.grepiu.com/post/74
- 조건 ? A : B; (삼항연산자)
- a?.test(); (a가 null이 아니면 test를 실행한다)
- a ??= b; (a가 null이면 b를 넣는다)
- a = b ?? c; (b가 null이 아니면 a에 배정한다. 아니면 c를 배정한다)
- 값! (값이 null 이 아니다고 확신하는 연산자)

## Transition 종류
- FadeTransition
- SlideTransition
- ScaleTransition
- RotationTransition
- SizeTransition

## Navigator push 종류
- pushAndRemoveUntil (현재 화면 변경 - 모든 화면 스택에서 사라짐)
- pushReplacement (현재 화면 변경 - 현재 화면 스택에서 사라짐)
# 아이패드 드로잉 앱

<br>

# [Step1] 사각형 클래스 및 팩토리 설계

- MVC중 Model에 해당
- 객체지향 프로그래밍 방식으로 설계
- Core Graphics를 사용하지 않고 구현
- print()가 아닌, 시스템 로그(OS Log) 함수를 통해 객체 출력


## OSLog를 이용한 출력

```swift
let Rect = randomRectangleFactory.createRandomShape()
os_log(.debug, log: .default, "\n\(Rect.description)")
```

*실행 결과*
```
2022-03-03 15:12:23.758258+0900 DrawingApp[48769:3124204] 
(afy-kw5-t7o), X: 45.0, Y: 44.0, W: 89.0, H: 92.0, R: 235.0, G: 198.0 B: 65.0
```

<br>

# [Step2] 속성 변경 동작 구현

- 사각형 객체를 관리하는 `plane` 클래스 설계
- 버튼 터치시 랜덤 사각형 생성 및 표시
- 탭 제스처를 통해 사각형 선택/선택 해제 기능 구현
- 배경색 조절 기능 구현
- 투명도 조절 기능 구현

![CleanShot 2022-03-15 at 22 50 53](https://user-images.githubusercontent.com/57667738/158392532-9c4dc961-163f-44f9-877a-66093f8ad842.gif)
# Step3-1. 아이패드 앱 프로젝트

## 💻 작업 목록

- [x] 필수 속성 고유아이디(String), 크기(Width, Height), 위치(X, Y), 배경색(R, G, B), 투명도(Alpha)를 가진 사각형 뷰를 표현하는 모델 클래스 설계하기
- [x] 고유아이디는 랜덤값으로 3자리-3자리-3자리 형태
- [x] 크기는 CGSize를 사용하면 안되며, Double 타입을 기준으로 처리한다. 필요하면 Size 타입을 선언
- [x] 위치는 CGPoint를 사용하면 안되며, Double 타입을 기준으로 처리한다. 필요하면 Point 타입을 선언
- [x] 배경색도 UIColor나 CGClor를 사용하면 안되며, RGB 각각 0부터 255 사이 값으로 처리
- [x] 투명도는 1-10사이값으로 10단계로 표현
- [x] 모델 클래스 파일은 Core Graphics나 UIKit에 독립적인 타입으로 선언한다. (해당 프레임워크를 import 하지 않아야 한다)
- [x] 모델 클래스 출력을 위해서 CustomStringConvertible 프로토콜을 추가하고 구현
- [x] 모델 클래스의 생성자에서 랜덤값을 처리하는 게 아니라, 랜덤값을 생성해서 모델 생성하는 초기값을 넘겨주는 팩토리를 구현


## 📱 실행 화면

![스크린샷 2022-03-04 오후 5 53 24](https://user-images.githubusercontent.com/95578975/156731250-4e7086f7-b58b-41cf-9c74-0e87469e1af8.png)

## 💡 학습 키워드

- 아이패드
- 클래스
- 뷰 모델
- os
- [Logging](https://developer.apple.com/documentation/os/logging)

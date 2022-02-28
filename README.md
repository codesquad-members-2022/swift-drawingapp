# swift-drawingapp - Ebony

----

## 기능요구사항

- [x] 객체지향 프로그래밍 방식으로 사각형 뷰를 표현하는 모델 클래스(class)를 설계한다.

- [x] 고유아이디는 랜덤값으로 3자리-3자리-3자리 형태

- [x] 배경색도 UIColor나 CGClor를 사용하면 안되며, RGB 각각 0부터 255 사이 값으로 처리한다.

- [x] 투명도는 1-10사이값으로 10단계로 표현한다.

- [x] 모델 클래스 파일은 Core Graphics나 UIKit에 독립적인 타입으로 선언한다. (해당 프레임워크를 import 하지 않아야 한다)

- [x] 모델 클래스 출력을 위해서 CustomStringConvertible 프로토콜을 추가하고 구현한다.

- [x] 모델 클래스의 생성자에서 랜덤값을 처리하는 게 아니라, 랜덤값을 생성해서 모델 생성하는 초기값을 넘겨주는 팩토리를 구현한다.

### 구현 과정
0. Square, SquareFactory, DrawingViewController가 어떤 역할을 하고, 어떤 변수를 갖을 지 고민한다.
1. SquareFactory를 구현한다.
    1. 랜덤 색, 좌표
    2. Square클래스를 만드는 함수.

### 결과 화면

<img width="614" alt="스크린샷 2022-02-28 오후 6 04 32" src="https://user-images.githubusercontent.com/62687919/155954858-632c1628-5e5c-4cf2-bc90-c07eab5acc23.png">

<img width="847" alt="스크린샷 2022-02-28 오후 8 55 06" src="https://user-images.githubusercontent.com/62687919/155979350-1062dec1-e066-4357-8fdd-e46a66cc323f.png">

### 고민했던 점.
1. 어떻게 하면 enum을 잘 활용할 수 있을까? : RandomValue
2. controller에서 요청한 데이터를 model에서는 어떻게 다시 보내야 할까? - protocol 사용.



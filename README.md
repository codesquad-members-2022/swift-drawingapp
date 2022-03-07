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
0. Rectangle, RectangleFactory, DrawingViewController가 어떤 역할을 하고, 어떤 변수를 갖을 지 고민한다.
1. RectangleFactory를 구현한다.
    1. 랜덤 색, 좌표
    2. Square클래스를 만드는 함수.

### 결과 화면

<img width="614" alt="스크린샷 2022-02-28 오후 6 04 32" src="https://user-images.githubusercontent.com/62687919/155954858-632c1628-5e5c-4cf2-bc90-c07eab5acc23.png">

<img width="847" alt="스크린샷 2022-02-28 오후 8 55 06" src="https://user-images.githubusercontent.com/62687919/155979350-1062dec1-e066-4357-8fdd-e46a66cc323f.png">

### 고민했던 점.
1. 어떻게 하면 enum을 잘 활용할 수 있을까? : RandomValue
2. controller에서 요청한 데이터를 model에서는 어떻게 다시 보내야 할까? - protocol 사용.

----

## 기능요구사항

- [x] 터치가 될 때마다 해당 위치에 사각형이 있다면 해당 사각형이 선택되고, 만약 사각형이 없다면 기존에 선택된 다른 사각형도 선택이 취소된다. (빈 영역을 선택할 경우만 선택 취소)
- [x] 사각형 테두리에 선을 표시해서 선택한 것을 인지할 수 있도록 한다. 사각형을 선택하면 화면 우측에 해당 사각형의 현재 배경색과 투명도가 반영된다.
- [x] 배경색 버튼에는 현재 배경색이 R-G-B 순서대로 16진수로 보이며, 버튼을 누를 때마다 랜덤한 추천 색상으로 변경한다.
- [x] 투명도는 10단계로 나눠서 변경할 수 있고, alpha값을 단계로 나눠서 적용한다.
- [x] 투명도 좌, 우에 버튼은 각각 투명도 단계를 -1, +1 시킨다. 만약 더 이상 작거나 커질 수 없으면 비활성화한다.

### 구현 과정
0. plane을 square가 갖도록 한다.
1. square가 추가될 때 마다 plane에 이를 추가한다.
2. square객체 관련 값을 수정할 때에는 plane에서 하도록 한다.
3. 테스트 코드를 작성한다.

### 결과 화면

![Simulator Screen Recording - iPad Air (4th generation) - 2022-03-07 at 17 51 36](https://user-images.githubusercontent.com/62687919/156999215-2142aa5f-b54d-4708-99e6-a4541f0db1a2.gif)

### 고민했던 점.
1. rectangle에서의 관련 기능들을 모두 plane안으로 어떻게 옮기고, 옮긴다면 설계를 어떻게 해야할까?
2. test코드를 작성하기 편리하게 하려면 어떤 방법이 있을까?
    - RectangleFactory를 Plane안으로 넣자!
3.결합을 느슨하게 할 수 있을까?
    - 값을 직접 메모리에 올리지 않고 프로토콜을 활용한다!



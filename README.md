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
0. SquareView, SquareAddButton, DrawingViewController, protocol, RandomLogic(model)등을 설계한다.
1. SquareView를 구현한다.
2. SquareView의 속성들을 임시로 넣어둔다.
3. SquareAddButton을 생성한다.
4. SquareAddButton의 터치이벤트를 추가하고, 이가 일어날 시 SquareView를 추가해본다.
5. 추가되는 것을 확인한 후 랜덤로직을 구현한다.
6. 랜덤로직의 값들을 확인해본 후, SquareViewState객체에 해당 정보들을 담는다.
7. 사각형 추가버튼이 탭되었을 시 동작할 로직함수를 프로토콜로 선언해둔다.
8. 버튼이 터치되면, 랜덤로직에서 랜덤값들을 생성한 후, 랜덤로직에서 ViewController로 생성된 사각형 정보를 보낸다.
9. 모델에서 추가된 정보를 이용하여 사각형을 생성한 후, 화면에 사각형 뷰를 추가한다.

### 결과 화면

<img width="614" alt="스크린샷 2022-02-28 오후 6 04 32" src="https://user-images.githubusercontent.com/62687919/155954858-632c1628-5e5c-4cf2-bc90-c07eab5acc23.png">

### 프로젝트 흐름

<img width="910" alt="스크린샷 2022-02-28 오후 6 14 50" src="https://user-images.githubusercontent.com/62687919/155956318-52e9b598-b0ef-4e0f-8b66-ebd0193d724e.png">

1. button이 터치된다.
2. RandomLogic에 SquareViewState생성을 요청한다.
3. SquareViewState가 완성될 시 다시 ViewController로 SquareView를 생성한 후 view에 추가한다.


### 고민했던 점.
1. 어떻게 하면 enum을 잘 활용할 수 있을까? : RandomValue
2. Square안에 랜덤값을 구현했었는데, view와 model이 한 클래스 안에 있는것 같다... 어떻게 분리하지?
    - RandomLogic클래스를 생성하여 Model과 view를 나눴습니다.
3. controller에서 요청한 데이터를 model에서는 어떻게 다시 보내야 할까? - protocol 사용.


- View도 분리하여 사용하면 편할 것 같아 SquareView와 SquareAddButton을 구현하였습니다. DrawingView는 step2의 과제같아 분리하지 않았습니다.


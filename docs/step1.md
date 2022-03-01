# 아이패드 앱 프로젝트

## 작업 목록

- [x] 사각형 뷰를 표현하는 모델 클래스(class) 설계 및 구현
- [x] 모델 클래스에 CustomStringConvertible 프로토콜을 추가하고 구현
- [x] 사각형 클래스를 생성하는 팩토리를 구현

## 학습 키워드

- MVC Pattern
- UITraitEnvironment
- UITraitCollection

### 질문

Swift 데이터 타입의 `extension`을 사용해 유틸리티 메소드를 추가할 경우에는 어떤 요소를 고려해야할까요? 작은 규모의 앱이라면 상황과 기호에 맞게 선택하면 될까요? 종종 이런 의문이 생길때면 너무 지엽적이어서 오히려 학습에 방해가 되는게 아닌가하는 생각이 들곤 합니다.

- 배경 - `Rectangle.id` 값을 생성하기 위해 `ShapeFactory.generateIdentifier()` 을 만들었습니다. 해당 메소드를 팩토리에 넣어도 되지만 `String` 타입의 `extension`에 추가해도 될 것 같다는 생각이 들었습니다.
  - `ShapeFactory` 에 추가한다면 `String` 타입에 대한 `ShapeFactory`의 의존성을 방지할 수 있으나 해당 메소드가 범용적으로 사용될 수 있다는 점에서 Factory 도메인과의 연관성은 낮아보입니다.
  - `String` 에 추가한다면 연관성은 높아보이지만 ShapeFactory 의 의존성이 높아질거라도 생각합니다.

# 관찰자(Observer) 패턴

## 작업 목록

- [x] 적용해 입력과 출력 흐름 분리
- [x] UI 요소에 AutoresizingMask 적용
- [x] NotificationCenter 사용해 Model-ViewController-View 흐름 구축

## 데모

<image src="../images/step3.gif" width="300px">

## 학습 키워드

- AutoresizingMask
- NotificationCenter
- Observer Pattern
- Hashable Protocol
- Property Observer

## 고민과 해결

- 모델 업데이트 후 View 에 반영하기 위해 Rectangle 모델 정보만을 가지고 해당하는 RectangleView 를 어떻게 찾아야할지 방법을 찾아야했습니다.

  - ViewController 에 `var rectangleMap: [Rectangle: RectangleView]` 를 추가해 모델과 View 의 참조를 매핑했습니다.

- 딕셔너리의 키값으로 클래스 인스턴스를 저장하는 과정에서 Hashable 프로토콜을 학습했습니다.

  - 유니크한 hash 값을 얻기 위해 `ObjectIdentifier` 로 얻은 메모리 주소값을 사용했습니다.

- 몇 가지 View 와 Model 만으로도 ViewController 의 코드량이 점점 많아지고 있는 것 같습니다.
  - Container View Controller 를 사용해 하위 ViewController 를 포함시켜 각 ViewController 가 담당하는 역할을 세분화시켜야할 것 같다는 생각이 들었습니다.

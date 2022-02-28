## 2022.02.28 step2-1

## 작업목록

- [x] Plane 구조체 구현
  - [x] 새로운 사각형 생성 시 Plane에 추가
  - [x] 사각형의 전체갯수를 알려주는 프로퍼티 제작
  - [x] Subscrit로 index를 넘기면 해당 사각형 모델 리턴
  - [x] 터치 좌표를 넘기면, 해당위치를 포함하는 사각형이 있는지 판단
  - [x] 테스트 코드 작성
- [x] 터치 시 해당위치에 사각형 선택
  - [x] 테스트 코드 작성
- [ ] 사각형이 없으면 기존 선택된 다른 사각형도 선택 취소
- [ ] 사각형 선택 시, 테두리에 선을 표시
- [ ] 사각형 선택 시, 화면 우측에 해당 사각형의 배경색과 투명도가 반영
- [ ] 투명도는 10단계, 각 단계별 알파값 적용
- [ ] 투명도 좌, 우에 투명도 단계를 조절하는 버튼을 만들고, 더이상 작거나 커질수 없으면 비활성화

## 고민과 해결

* **UITapGestureRecognizer.UIGestureRecognizerDelegate**

  * UIGestureRecognizerDelegate 채택 시 사용할 수 있는 이벤트에 대해 궁굼해짐

  * 우선은  event, touch, shouldBegin, Press 4가지 동작 확인

    * 4가지 모두 return true

      ```
      // 일반 터치 시
      Event
      Touch Event
      ShouldBegin
      
      //터치 후 일정 시간 후 떼기
      Event
      Touch Event
      ```

    * ShouldBegin만 false

      * 위와 같음

    * touch를 false

      * ShouldBegin의 이벤트가 발생하지 않음

      ```
      // 일반 터치 시
      Event
      Touch Event
      
      //터치 후 일정 시간 후 떼기
      Event
      Touch Event
      ```

    * event를 false

      * Touch Event, ShouldBegin의 이벤트가 발생하지 않음

      ```
      // 일반 터치 시
      Event
      
      //터치 후 일정 시간 후 떼기
      Event
      ```

  * 위의 테스트로 알 수 있는것

    1. Event -> Touch -> ShouldBegin 순으로 이벤트가 발생
    2. 각 구간에서 Bool를 리턴해 주는데, 해당 구간에서 false를 리턴하면 이후 이벤트는 발생하지 않음
    3. Press이벤트는 발생하지 않음

  * 그 외에도 여러 이벤트들이 있지만 어떤 타이밍에 발생하는지 파악 필요

    * shouldRequireFailureOf
    * shouldBeRequiredToFailBy
    * shouldRecognizeSimultaneouslyWith
    * press

## 2022.02.28 Step1

## 작업목록

- [x] 사각형을 관리할 클래스 제작
  - [x] 좌표를 관리할 클래스 제작, CGPoint 사용하지 않기
  - [x] 크기를 관리할 클래스 제작, CGSize 사용하지 않기
  - [x] 색상을 관리할 클래스 제작, UIColor 사용하지 않기
  - [x] alpha를 표시할 enum 제작
- [x] 사각형을 만들어 줄 팩토리 구현
- [x] CustomStringConvertible을 사용하고, 구현하기
- [x] os_log 사용하기

## 고민과 해결

* Factory
  * 팩토리를 이용해 인스턴스를 생성 할 때, 사각형에 필요한 인자값을 다 넘겨 주어야 할까??
    아니면 임시값으로 적용하여 생성 후 추후에 수정을 해야할까?
    * 인자값을 넘겨주기에는 많은 값들이 필요하다고 생각하여 우선은 임시값을 넣어 생성
    * 우선 아이디값만 생성하고, 사각형을 만들 수 있도록 구현
  * 팩토리 클래스 안에서 각 객체 인스턴스에 필요한 코드를 다 구현해야할까?
    * 팩토리클래스 안에 사각형을 만드는 코드( 아이디를 랜덤으로 만들고,, 값을 넣고..)를 넣어야 하는지 고민
    * 팩토리 클래스에 많은 코드가 들어가게 될것같음
    * 그래서 각 객체에 static로 make 함수를 제작, 각 클래스에서 인스턴스 생성 후 넘겨주도록하고
      그 관리는 Factory에서 하도록 함
  * size, point, color 클래스의 객체들도 팩토리로 넣어야 할까?
    * 위의 클래스들은 최하위 객체들로 판단되기에 Factory에 넣지는 않음

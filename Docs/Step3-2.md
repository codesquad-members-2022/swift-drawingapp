# Step3-2. 속성 변경 동작

## 💻 작업 목록

- [x] 지난 PR 리뷰 반영
  - [x] Alpha 내부에 opacity 변수로 투명도 나타내도록 수정
  - [x] 이니셜라이저에서 minValue = 0, maxValue = 255로 두고 비교하여 minValue보다 작은 값이 들어온다면 0을, maxValue보다 큰 값이 들어오면 255를 주도록 수정
  - [x] Id 클래스를 따로 생성하고 내부에 메소드 추가
  - [x] 팩토리 메소드 수정
- [x] SideInspectorView 생성
- [x] SideInsepctorView에서 사각형 버튼 클릭 시, 뷰컨트롤러가 직사각형 그리도록 delegate 설정
- [x] Plane 구조체 Test 추가하기
- [x] SideInspectorView를 제외한 영역에 사각형이 그려지도록 하기
- [x] 터치될 떄마다 해당 위치에 사각형이 있는지 확인
  - [x] 사각형이 있다면, 사각형이 선택된다.
  - [x] 사각형이 없다면 기존에 선택된 사각형을 선택 취소한다. 기존에 선택된 사각형이 없을 경우 아무 동작도 하지 않는다.
- [x] 사각형 테두리에 선을 표시해서 선택된 것을 인지시키기
- [x] 사각형을 선택하면 화면 우측에 해당 사각형의 현재 배경색과 투명도가 반영된다.
- [x] 배경색 버튼 누르면 랜덤한 추천 색상으로 변경
- [x] 투명도는 10단계로 나눠서 변경하고, alpha 값을 단계로 나눠 적용한다.
- [x] 투명도 좌, 우에 버튼은 각각 투명도 단계를 -1, +1 시킨다. 

## 📱 실행 화면

![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/95578975/158830805-a03375ac-5805-4db5-81a1-fe07c396acfb.gif)

## 🤔 고민과 해결

### 1️⃣ Alpha에 opacity를 추가하는 과정에서 오차 발생

Alpha의 rawValue 값을 Double로 변환하고, 그 결과를 0.1로 곱하는 과정에서 오차가 발생했습니다.

rawValue를 Double로 변환하는 데까지는 문제가 없었지만, 0.1로 곱하는 과정에서 부동 소수점의 부정확성으로 인해 오차가 발생한 것인데, 0.1을 곱하지 않고 10을 나눠주는 방식으로 변경하여 해결하였습니다.

### 2️⃣ 색상 값을 16진수로 나타내는 backgroundColorValueView 속성 적용 문제

backgroundColorValueView의 width, height를 설정해주지 않아서 생긴 문제였습니다. width, height 설정하니 해결되었습니다.
 
### 4️⃣ 뷰에서 선택한 좌표에 사각형이 있는지 표시하기

- 뷰에서 이벤트가 발생할 경우, UITapGesture로 뷰에서 선택한 좌표를 먼저 얻었습니다. 
- ViewController를 CanvasView의 Delegate로 지정하여 VC에 좌표를 전달하고 (`canvasViewDidTouched`), 해당 좌표가 Plane 내의 직사각형을 포함하는지 확인하였습니다. (`findRectangle(on:)`) 
- 선택된 좌표에 직사각형이 존재한다면 Plane은 `findRectangle(on:)`에서 직사각형을 리턴하고, 직사각형이 존재하지 않는다면 nil을 리턴하도록 하였습니다. 
  - ViewController에 선택된 직사각형을 나타내는 selectedRectangle이란 변수를 만들었습니다.
  - 직사각형이 존재한다면 selectedRectangle에 저장해주었고, canvasView에 해당 직사각형이 선택되었다고 표시하도록 하였습니다.
  - 직사각형이 존재하지 않는다면 아무 것도 없는 빈 공간을 선택한 것이므로 canvasView의 `initializeRectangle()`를 호출하여 선택된 직사각형이 없도록 하였습니다. (이전에 선택된 직사각형이 있을 수도 있기 때문에) 그리고 selectedRectangle를 nil로 변경하였습니다.

### 5️⃣ 사각형을 선택하면 화면 우측에 해당 사각형의 현재 배경색, 투명도 반영하기

- ViewController가 뷰에서 사각형을 선택했다는 것은 위의 4️⃣의 과정 (`findRectangle`)을 통해서 알아올 수 있었습니다. ViewController를 Plane의 delegate로 지정하였고, `planeDidTouchedRectangle(_:)` 메소드를 통해 선택된 사각형의 색상과 투명도 값을 SideInspectorView에 전달하였습니다.

### 6️⃣ 사각형의 속성 변경하기 - 색상 버튼이 탭 되었을 때, 슬라이더 값이 변경되었을 때

- SideInspectorView에서 색상 버튼이 탭 되는 경우는 `sideInspectorViewDidTappedColorButton(_:)` 메소드를, 슬라이더 값이 변경되었을 때의 경우는 `sideInspectorViewSliderValueDidChanged(_:)` 메소드를 사용하였습니다.

- ViewController를 SideInspectorView의 delegate로 지정했고, 색상 버튼을 누르면 색상 값을 랜덤으로 생성한 후에 Plane에 `backgroundColorDidChanged(color:rectangle:)` 를 통해 현재 직사각형과 변경된 색상을 전달하였습니다.
- ViewController를 SideInspectorView의 delegate로 지정했고, 변경된 슬라이더 알파 값을 Plane에 `alphaValueDidChanged(alpha:rectangle:)` 메소드를 통해 현재 직사각형과 변경된 투명도 값을 전달하였습니다.
- Plane에서는 속성이 변경된 직사각형을 찾아서 값을 변경한 후에 ViewController에 `planeDidChangedRectangle(_:)` 메소드로 변경된 직사각형을 알렸고, ViewController는 CanvasView에게 해당 속성이 변경된 것을 뷰에 알리도록 하였습니다. (`changeRectangle(_:)`)

## 💡 학습 키워드

- 아이패드
- 클래스
- 뷰 모델
- viewDidLayoutSubviews()
- MVC
- Delegate
- Protocol
- layer
- border

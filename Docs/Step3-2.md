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

### 3️⃣ 뷰와 모델 분리하기

MVC 패턴에 따라 뷰와 모델을 따로 분리하여 입출력 흐름을 분리하는 것이 많이 어려웠지만, 다른 분들의 도움으로 해결할 수 있었습니다.

## 💡 학습 키워드

- 아이패드
- 클래스
- 뷰 모델
- viewDidLayoutSubviews()

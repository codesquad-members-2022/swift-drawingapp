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
- [ ] SideInspectorView를 제외한 영역에 사각형이 그려지도록 하기
  - [x] 일단 범위를 제한적으로 설정하여 사각형이 그리도록 함

## 🤔 고민과 해결

### 1️⃣ Alpha에 opacity를 추가하는 과정에서 오차 발생

Alpha의 rawValue 값을 Double로 변환하고, 그 결과를 0.1로 곱하는 과정에서 오차가 발생했습니다.

rawValue를 Double로 변환하는 데까지는 문제가 없었지만, 0.1로 곱하는 과정에서 부동 소수점의 부정확성으로 인해 오차가 발생한 것인데, 0.1을 곱하지 않고 10을 나눠주는 방식으로 변경하여 해결하였습니다.

### 2️⃣ 색상 값을 16진수로 나타내는 backgroundColorValueView 속성 적용 문제

backgroundColorValueView의 width, height를 설정해주지 않아서 생긴 문제였습니다. width, height 설정하니 해결되었습니다.

### 3️⃣ SideInspectorView를 제외한 영역에만 사각형 그리도록 설정하기

#### 💡 아이디어: SideInspectorView의 시작 x 좌표를 가져와서 그 x 좌표 이상은 안 그리게 하기

- viewDidLoad 내에서 `setInspectorView()`를 호출한 후에 `sideInspectorView.frame` 값을 확인해보았으나, 값을 가져오지 못했습니다. (모두 0 이였습니다). 레이아웃 제약 조건이 오토레이아웃에 의해 배치되지 않기 때문에, `viewDidLayoutSubview()` 메소드를 오버라이드한 후에 접근하면 값을 가져올 수 있었습니다.
- 아직 진행 중입니다...!

## 💡 학습 키워드

- 아이패드
- 클래스
- 뷰 모델
- viewDidLayoutSubviews()

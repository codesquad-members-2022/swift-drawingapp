# iOS - DrawingApp



## Step2. 속성 변경 동작 및 Unit Test

### 📌주요 작업 내용

- [x] 사각형 뷰와 Rectangle 객체의 매칭을 위해, id 프로퍼티를 가지는 UIView를 RectangleView로 생성

- [x] GestureRecognizer를 이용해 Rectangle에 대한 터치 구현

- [x] 우측의 속성 변경 버튼/슬라이더를 이용해 선택된 Rectangle, RectangleView의 속성 변경하도록 구현

- [x] Delegate 패턴을 이용해 Plane 객체가 Rectangle의 속성이 변경된 것을 VC에게 알려주도록 구현

- [x] Unit Test 작성

---

### 💻작업 진행과정

1. Rectangle과 사각형 UIView와의 매칭을 위해, id 프로퍼티를 가지는 UIView인 RectangleView 구현

2. UITapGestureRecognizer를 이용해, 터치된 좌표를 Plane에게 알려주도록 설정

3. Delegate 패턴을 이용해 터치된 좌표에 있는 Rectangle이 있을 경우 Plane이 ViewController에게 알려주도록 설정(선택된 Rectangle 객체를 넘겨줌)

	ViewController는 선택된 Rectangle을 가지고 RectangleView와 매칭시키고, 매칭된 RectangleView의 속성(배경색, 투명도)을 오른쪽 StatusView 상의 View들에 표시

4. 배경색 버튼을 누르면 랜덤한 배경색이 생성되도록 하기 위해 기존에 RectangleFactory 내에 있던 랜덤 BackgroundColor 생성 메서드를 따로 분리해 BackgroundColorFactory 구현

	Alpha, Point 타입들에 대한 Factory도 구현

5. 배경색 버튼을 누르면 Rectangle의 배경색을 랜덤하게 바꾸고, 매칭된 RectangleView, 배경색 버튼 색과 배경색 버튼의 title도 해당 배경색에 맞게 변경하도록 하는 기능 추가

6. 슬라이더를 헤드를 이동시키면 선택된 Rectangle, 매칭된 RectangleView의 alpha 값, 배경색 버튼의 backgroundColor의 alpha 값을 변경시켜주는 기능 추가

7. 빈공간을 터치하면 선택됐던 Rectangle이 선택 취소되고 StatusView에 있는 버튼 및 슬라이더가 Disable한 상태로 전환되도록 설정

8. 선택된 Rectangle의 alpha값을 단계적으로 올리고 내릴 수 있는 `-` , `+` 버튼 추가

9. Unit Test 작성

10. 리팩토링

	1. Alpha의 값을 설정할 때 컴파일 단계에서 해당 값을 제한할 수 있도록, Alpha 타입의 OpacityLevel이라는 프로퍼티에 대한 타입을 선언

	2. 델리게이트 메서드의 이름을 컨벤션에 맞게 수정 

		(Plane객체의 이벤트를 전달해주는 Delegate 패턴이므로, 메서드 이름의 제일 앞 부분이 `plane-` 으로 시작하고, 매개변수가 plane이도록 수정)

	3. 모델 객체와 뷰 객체를 매칭해놓은 Dictionary 타입의 프로퍼티를 ViewController가 갖고 있도록 하여, ViewController에서 변경된 모델 객체를 이용해 매칭되는 뷰 객체를 O(1)로 찾을 수 있도록 수정

		(이전에는 모델 객체의 id 프로퍼티를 이용하기 위해 뷰 객체에도 매칭을 위한 id 프로퍼티를 선언해주었고, 시간 복잡도 또한 O(n) 이었음)

	4. 입력 - 출력의 흐름을 Delegate 패턴을 이용해 나누고, 빈 칸을 터치했을 때의 동작 또한 입력 흐름이 아닌 출력 흐름에서 처리하도록 수정

	

> 완성 일시: 2022.03.11 01:29

---

### 📋프로그램 동작 화면

1. `사각형 생성` 버튼을 누르면 임의의 좌표에 임의의 배경색, 임의의 투명도를 가진 사각형이 생성됩니다.
2. 생성된 사각형을 터치하면 오른쪽의 `배경색 버튼` 과 `투명도 조절 버튼`, 그리고 `투명도 조절 슬라이더` 가 활성화됩니다.
	1. `배경색 버튼`을 누르면 선택된 사각형의 **배경색**이 랜덤으로 변경됩니다.
	2. `투명도 버튼`을 누르거나, `투명도 슬라이더` 를 조절하면 선택된 사각형의 **투명도**가 변경됩니다.
3. 빈공간을 터치하면 오른쪽의 버튼, 슬라이더가 비활성화됩니다.

<img src="https://user-images.githubusercontent.com/92504186/157002715-f7827f7a-063d-4448-acf4-a16ce61eb832.gif" alt="SS 2022-03-07 PM 06 18 45" width="50%;" />
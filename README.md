# iOS - Drawing App



## Step1. 사각형, 사각형 팩토리 객체 구현

### 📌주요 작업 내용

- [x] 사각형에 해당하는 객체 구현
	- [x] 사각형의 프로퍼티 타입에 해당하는 구조체 구현
	- [x] 속성값의 범위가 존재하는 타입은 초기화 단계에서 범위 제한
- [x] 사각형 객체를 생성하는 팩토리 객체 RectangleFactory 구현
- [x] 사각형 인스턴스 생성 후 `os_log` 이용하여 콘솔에 객체 정보 출력

---

### 💻작업 진행과정

1. Rectangle 객체 구현

2. Rectangle 프로퍼티의 타입을 위한 구조체 구현(Size, Point, BackgroundColor, Alpha)

3. 사각형 객체를 생성하는 팩토리 객체 RectangleFactory 구현

4. 사각형 객체가 생성되면(RectangleFactory의 generateRandomRectangle() 메서드 호출 시) 해당 객체의 정보를 출력하도록 Delegate 패턴으로 구현(테스트용)

5. 리팩토링

	1. ID에 해당하는 타입 구현

		ID는 외부에서 지정해주기 보다는, 내부에서 임의로 생성해 지정해주는 것이 좋다고 판단해서 ID 구조체 내에 static function으로 `generateRandomID()` 메서드를 선언해, ID 타입 초기화 단계에서 랜덤한 ID를 지정해주도록 설정

	2. Alpha의 단계에 대한 의미를 명확히 하도록 수정

		Alpha 타입을 열거형에서 구조체로 바꾸어, 해당 구조체가 초기화될 때 `opacityLevel` 이라는 매개변수를 이용해 해당 값은 `불투명 정도` 를 정하는 값이라는 내용을 명시

	3. Alpha의 값 범위에 대한 제한 설정

		프로그래밍 요구사항 내에 존재하는 제한 범위를 지키도록, Alpha 타입 초기화 시 범위를 초과하는 값이 들어오면 최솟값 또는 최댓값을 가지도록 설정

> 완성 일시: 2022.03.02/ 15:40

---

### 📋프로그램 내용

1. ViewController에서 RectangleFactory를 이용해 사각형 객체를 생성하면 콘솔에 해당 객체에 대한 설명을 출력합니다.

	<img src="https://user-images.githubusercontent.com/92504186/156004800-2577d77f-8590-460c-ad25-640cb9b9fe3d.jpg" alt="SS 2022-02-28 PM 11 36 52" width="90%;" />

	


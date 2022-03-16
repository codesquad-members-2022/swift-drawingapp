# iOS - DrawingApp



## Step3. 관찰자(Observer) 패턴

### :pushpin:주요 작업 내용

- [x] ViewContoller에서, 뷰로 부터의 입력 이벤트를 처리하기 위해 NotificationCenter를 이용한 Observer 패턴 사용
	- [x] 이전에 사용하던 Delegate 패턴은 모두 제거
- [x] ViewController, Plane이 구체 타입이 아닌 추상 타입에 의존하도록 수정
	- [x] RectangleView, Rectangle 객체에 대한 추상 타입으로 RectangleViewable, Rectangularable 프로토콜 선언
	- [x] ViewFactory와 RectangleFactory가 추상 타입을 반환하도록 수정

---

### :computer:작업 진행과정

1. ViewController에서 Plane객체의 변화에 대한 옵저버 설정 및 변화가 감지되면 실행될 메서드 선언

	```swift
	// class ViewController
	NotificationCenter.default.addObserver(self, selector: #selector(planeDidAddRectangle(_:)), name: Plane.NotificationNames.didAddRectangle, object: plane)
	
	@objc func planeDidAddRectangle(_ notification: Notification) {
	    // Plane이 Rectangle을 추가했을 때 ViewController에서 실행할 내용
	}
	```

2. Plane에서 어떤 메서드가 호출되면 변화에 대한 내용을 post하도록 설정

	```swift
	// class Plane
	public func addNewRectangle(in frame: (width: Double, height: Double)) {
	    // ... Rectangle 추가하는 과정
	    NotificationCenter.default.post(name: Plane.NotificationNames.didAddRectangle, object: self, userInfo: [Plane.UserIDKeys.addedRectangle: newRectangle])
	}
	```

3. RectangleView가 채택하여, ViewController에서 참조할 추상 타입으로 RectangleViewable 프로토콜 선언

4. Rectangle이 채택하여, ViewController와 Plane에서 참조할 추상 타입으로 Rectangularable 프로토콜 선언

5. ViewFactory와 RectangleFactory가 추상 타입을 반환하도록 수정

6. Plane, ViewController가 최대한 구체 타입에 의존하지 않도록 수정(수정이 더 필요함)



> 완성 일시: 2022.03.14 10:40

---

### :clipboard:프로그램 동작 화면

~~위의 Step2와 동일합니다~~
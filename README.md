# swift-drawingapp
3번째 미션 - iOS 터치 드로잉 앱

## step1 주요  작업 내용
- [x] Device - iPad, Device Orientation - Landscape Left, Landscape Right)
- [x] Factory 클래스에서 랜덤하게 Rectangle 클래스 생성

## 구현 화면(2022.03.04)

```
struct BackgroundColor {
        let R: UInt8
        let G: UInt8
        let B: UInt8
        
        static func random() -> Self {
            let randomR: UInt8 = UInt8.random(in: 0...255)
            let randomG: UInt8 = UInt8.random(in: 0...255)
            let randomB: UInt8 = UInt8.random(in: 0...255)
            return RectangleView.BackgroundColor(R: randomR, G: randomG, B: randomB)
        }
    }
    struct Size {
        let width: Double = 150.0
        let height: Double = 120.0
    }
    struct Point {
        let x: Double
        let y: Double
        
        static func random() -> Self {
            let randomX: Double = Double.random(in: 20...1010)
            let randomY: Double = Double.random(in: 24...680)
            return RectangleView.Point(x: randomX, y: randomY)
        }
    }
```

![os_log](https://user-images.githubusercontent.com/50472122/156562405-f07d43dc-e2a6-4b82-81de-cb4ac1381613.png)

## step2 주요 작업 내용

- [x] MVC 중에서 M -> C 로 갈 때 delegate 패턴을 적용
- [x] "사각형" 버튼을 누르면 사각형 View 추가
- [x] Slider 의 변화에 따라 view 투명도 조절
- [x] 버튼 누르면 사각형 뷰의 색이 변경 
    - [x] 색 버튼의 title 변경 
- [x] 선택된 사각형 뷰에 선택됨을 알리표는 테두리 추가
    - [x] 화면에 다른 사각형을 선택시 테두리 걷어가기

## 주요 구현 모습

### 사각형 버튼을 누르면 사각형 UIView 를 추가

* ViewController.swift

```
    @IBAction func rectangleButtonTouched(_ sender: Any) {
        self.plane.addRectangle()
    }

    override func viewDidLoad() {
	super.viewDidLoad()
	plane.addedRectangleDelegate = self
    }

```

* Plane.swift

```
    var addedRectangleDelegate :RectangleAddedDelegate?

    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangles.append(rectangle)

        addedRectangleDelegate?.made(rectangle: rectangle)
    }

...

protocol RectangleAddedDelegate {
    func made(rectangle : Rectangle)
}

```

* extension : ViewController

```

extension ViewController: RectangleAddedDelegate {
    func made(rectangle: Rectangle) {
        let rectView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        rectView.backgroundColor = UIColor(red: CGFloat(rectangle.color.R)/255.0, green: CGFloat(rectangle.color.G)/255.0, blue: CGFloat(rectangle.color.B)/255.0, alpha: CGFloat(rectangle.alpha.rawValue)/10.0)
        self.rectangleAndViewContainer[rectangle] = rectView
        self.view.addSubview(rectView)
    }
}

```

### 배경에 tap이 될 수 있도록 적용

> ViewController 에 UIGestureRecognizerDelegate 를 적용하고 그 함수를 채택해야함

* ViewController.swift

```
    override func viewDidLoad() {
        super.viewDidLoad()
        activateBackgroundTappable()
    }

extension ViewController: UIGestureRecognizerDelegate {
        func activateBackgroundTappable() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            self.view.addGestureRecognizer(tap)
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let viewPoint: CGPoint = sender.location(in: self.view)
            let rectPoint: Point = Point(x: viewPoint.x, y: viewPoint.y)
            plane.touchedRectangle(at: rectPoint)
        }
}

```

## step3 주요 구현내용

- [x] Delegate로 작동하는 것을 NotificationCenter 를 이용하도록 설정
    - [x] 사각형 추가 기능
    - [x] rectangle view 를 터치하면 테두리 설정
    - [x] rectangle color 변경
    - [x] rectangle alpha 변경

### 사각형 추가 기능을 NotificationCenter 를 이용해서 설정

* NotificationCenter.swift

```
let notificationCenter = NotificationCenter.default

extension Notification.Name {
    static let addRectangleView = Notification.Name("A rectangle is made")
    static let tappedRectangleView = Notification.Name("a rectangle view is Tapped")
    static let colorChange = Notification.Name("color changed")
    static let alphaChange = Notification.Name("alpha changed")
}

enum NotificationKey {
    case color
    case alpha
    case tappedRectangle
    case addedRectangle
}

```

* Plane.swift

```
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangles.append(rectangle)
	// Notification.post
        notificationCenter.post(name: .addRectangleView, object: nil, userInfo: [NotificationKey.addedRectangle : rectangle])
    }
```

* ViewController.swift

```
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.addObserver(self, selector: #selector(made(rectangleNoti: )), name: Notification.Name.addRectangleView, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        notificationCenter.removeObserver(self)
    }

    @objc func made(rectangleNoti : Notification) {
        guard let rectangle = rectangleNoti.userInfo?[NotificationKey.addedRectangle] as? Rectangle else {
            return
        }
        let rectView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        rectView.backgroundColor = UIColor(red: CGFloat(rectangle.color.R)/255.0, green: CGFloat(rectangle.color.G)/255.0, blue: CGFloat(rectangle.color.B)/255.0, alpha: CGFloat(rectangle.alpha.rawValue)/10.0)
        self.rectangleAndViewContainer[rectangle] = rectView
        self.view.addSubview(rectView)
    }

```

## 구현화면

![drawing-step3](https://user-images.githubusercontent.com/50472122/158532985-1b8aea8d-307d-42f8-81f6-5adad2744bf2.gif)


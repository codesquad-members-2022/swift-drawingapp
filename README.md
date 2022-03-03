# 아이패드 드로잉 앱

- [Step1](#[Step1]-사각형-클래스-및-팩토리-설계)


<br>
<br>
<br>

# [Step1] 사각형 클래스 및 팩토리 설계

- MVC중 Model에 해당
- 객체지향 프로그래밍 방식으로 설계
- Core Graphics를 사용하지 않고 구현
- print()가 아닌, 시스템 로그(OS Log) 함수를 통해 객체 출력

- 필수 속성
    - 고유 아이디
        - `3글자-3글자-3글자` 형식
    - 크기
        - width, height
    - 위치
        - X, Y
    - 배경색
        - R, G, B
        - 0 ~ 255 범위
    - 투명도
        - 1단계 ~ 10단계

<br>
<br>

## *Rectangle class 구현*

### protocol `Shapable` :  *`CustomStringConvertible`*

```swift
protocol Shapable: CustomStringConvertible {
	var id: Identifier { get }
	var size: Size { get }
	var point: Point { get }
	var backGroundColor: Color { get }
}

extension Shapable {
    var description: String {
        return "(\(self.id)), \(self.point), \(self.size), \(self.backGroundColor)"
    }
}
```
<br>

### class *`Rectangle` : `Shapable`*

```swift
class Rectangle: Shapable {
    private(set) var id: Identifier
    private(set) var size: Size
    private(set) var point: Point
    private(set) var backGroundColor: Color
    private(set) var alpha: Alpha
    
    init(identifier: Identifier,
         size: Size = Size(width: 150, height: 120),
         point: Point,
         backGroundColor: Color,
         alpha: Alpha)
    {
        self.id = identifier
        self.size = size
        self.point = point
        self.backGroundColor = backGroundColor
        self.alpha = alpha
    }
}
```

- id: `Identifier`
    - <details>

        ```swift
        class Identifier {
            private var firstToken: String
            private var secondToken: String
            private var thirdToken: String
            
            init(firstToken: String, secondToken: String, thirdToken: String) {
                self.firstToken = firstToken
                self.secondToken = secondToken
                self.thirdToken = thirdToken
            }
            
            convenience init() {
                let firstToken = Identifier.generateRandomToken()
                let secondToken = Identifier.generateRandomToken()
                let thirdToken = Identifier.generateRandomToken()
                
                self.init(firstToken: firstToken, secondToken: secondToken, thirdToken: thirdToken)
            }
            
            static func generateRandomToken() -> String {
                let characters = Array(Bound.alphaNumeric)
                
                var id = ""
                (0..<Bound.tokenLength).forEach { _ in
                    let randomCharacter = characters[Int.random(in: (0..<characters.count))]
                    id.append(randomCharacter)
                }
                return id
            }
        }
        
        extension Identifier: CustomStringConvertible {
            var description: String {
                return "\(self.firstToken)-\(self.secondToken)-\(self.thirdToken)"
            }
        }
        
        extension Identifier {
            enum Bound {
                static let alphaNumeric = "abcdefghijklmnopqrstuvwxyz0123456789"
                static let tokenLength = 3
            }
        }
        ```
        

- size: `Size`
    - <details>
        
        ```swift
        struct Size {
            private var width: Double
            private var height: Double
            
            init(width: Double, height: Double) {
                self.width = width
                self.height = height
            }
        }
        
        extension Size {
            enum Bound {
                static let lowwer = 0.0
                static let upper = 100.0
            }
        }
        
        extension Size: CustomStringConvertible {
            var description: String {
                return "W: \(self.width), H: \(self.height)"
            }
        }
        ```
        

- point: `Point`
    - <details>
        
        ```swift
        struct Point {
            private var x: Double
            private var y: Double
            
            init(x: Double, y: Double) {
                self.x = x
                self.y = y
            }
        }
        
        extension Point {
            enum Bound {
                static let lowwer = 0.0
                static let upper = 100.0
            }
        }
        
        extension Point: CustomStringConvertible {
            var description: String {
                return "X: \(self.x), Y: \(self.y)"
            }
        }
        ```
        

- backgroundColor: `Color`
    - <details>
        
        ```swift
        class Color {
            private var red: Double
            private var green: Double
            private var blue: Double
            
            init(validRed: Double, validGreen: Double, validBlue: Double) {
                self.red = validRed
                self.green = validGreen
                self.blue = validBlue
            }
            
            convenience init?(red: Double, green: Double, blue: Double) {
                if red < Bound.lowwer || red > Bound.upper ||
                    green < Bound.lowwer || green > Bound.upper ||
                    blue < Bound.lowwer || blue > Bound.upper
                {
                    return nil
                }
                
                self.init(validRed: red, validGreen: green, validBlue: blue)
            }
        }
        
        extension Color {
            enum Bound {
                static let lowwer = 0.0
                static let upper = 255.0
            }
        }
        
        extension Color: CustomStringConvertible {
            var description: String {
                return "R: \(self.red), G: \(self.green) B: \(self.blue)"
            }
        }
        ```
        
    
    - alpha: `Alpha`
        - <details>
            
            ```swift
            enum Alpha: Double {
                case level1 = 0.1
                case level2 = 0.2
                case level3 = 0.3
                case level4 = 0.4
                case level5 = 0.5
                case level6 = 0.6
                case level7 = 0.7
                case level8 = 0.8
                case level9 = 0.9
                case level10 = 1.0
            }
            
            extension Alpha: CustomStringConvertible {
                var description: String {
                    return "Alpha: \(self.rawValue)"
                }
            }
            
            extension Alpha: CaseIterable {
                static var random: Alpha {
                    var shuffledAllCases = Alpha.allCases.shuffled()
                    return shuffledAllCases.removeLast()
                }
            }
            ```
            
<br>
<br>

## *Rectangle Factory class 구현*

### protocol `RandomRectangleFactorable`

```swift
protocol RandomRectangleFactorable {
    func generateRandomIdentifier() -> Identifier
    func generateRandomSize() -> Size
    func generateRandomPoint() -> Point
    func generateRandomColor() -> Color
    
    func createRandomShape() -> Shapable
}
```
<br>

### class `RectangleFactory`: `RandomRectangleFactorable`

```swift
class RectangleFactory {

    func createRactangle(identifier: Identifier,
                         size: Size,
                         point: Point,
                         color: Color,
                         alpha: Alpha) -> Rectangle {
        
        return Rectangle(identifier: identifier,
                         size: size,
                         point: point,
                         backGroundColor: color,
                         alpha: alpha)
    }
}
```

- `extension RectangleFactory: RandomRectangleFactorable`
    - <details>
        
        ```swift
        extension RectangleFactory: RandomRectangleFactorable {
            
            func generateRandomIdentifier() -> Identifier {
                return Identifier()
            }
            
            func generateRandomSize() -> Size {
                let validRange = (Size.Bound.lowwer...Size.Bound.upper)
                
                let randomWidth = round(Double.random(in: validRange))
                let randomHeight = round(Double.random(in: validRange))
                
                return Size(width: randomWidth, height: randomHeight)
            }
            
            func generateRandomPoint() -> Point {
                let validRange = (Point.Bound.lowwer...Point.Bound.upper)
                
                let randomX = round(Double.random(in: validRange))
                let randomY = round(Double.random(in: validRange))
                
                return Point(x: randomX, y: randomY)
            }
            
            func generateRandomColor() -> Color {
                let validRange = (Color.Bound.lowwer...Color.Bound.upper)
                
                let randomRed = round(Double.random(in: validRange))
                let randomGreen = round(Double.random(in: validRange))
                let randomBlue = round(Double.random(in: validRange))
                
                return Color(validRed: randomRed, validGreen: randomGreen, validBlue: randomBlue)
            }
            
            func createRandomShape() -> Shapable {
                return Rectangle(identifier: generateRandomIdentifier(),
                                 size: generateRandomSize(),
                                 point: generateRandomPoint(),
                                 backGroundColor: generateRandomColor(),
                                 alpha: Alpha.random)
            }
        }
        ```
        

<br>
<br>

## OSLog를 이용한 출력

```swift
let Rect = randomRectangleFactory.createRandomShape()
os_log(.debug, log: .default, "\n\(Rect.description)")
```

- <details>
    
    ```swift
    import UIKit
    import OSLog
    
    class ViewController: UIViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let randomRectangleFactory = RectangleFactory()
            
            (0..<4).forEach { _ in
                let Rect = randomRectangleFactory.createRandomShape()
                os_log(.debug, log: .default, "\n\(Rect.description)")
            }
        }
    }
    ```
    

*실행 결과*
```
2022-03-03 15:12:23.758258+0900 DrawingApp[48769:3124204] 
(afy-kw5-t7o), X: 45.0, Y: 44.0, W: 89.0, H: 92.0, R: 235.0, G: 198.0 B: 65.0
```
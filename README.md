# swift-drawingapp
3번째 미션 - iOS 터치 드로잉 앱



# Step1 [22.03.04 16:10]



### 🎯진행사항

- 프로젝트를 생성, 기본 앱 설정 

  <img src="/Users/choeyeju/Desktop/스크린샷 2022-03-07 오전 10.42.49.png" alt="스크린샷 2022-03-07 오전 10.42.49" style="zoom:80%;" />



- 사각형 뷰를 표현하는 Model 정의하기 

  - Rectangle Class 

    > 문제에서 요구한 필수 속성들을 private var로 선언하였고, 
    >
    > 하위 타입으로 나눌 수 있는 속성들은 새로운 타입을 만들어서 구현 
    >
    >
    > 모델 클래스 정보를 출력하기 위해 `CustomStringConvertible` 프로토콜을 채택

    

    ```swift
    class Rectangle: CustomStringConvertible{
        
        private var ID: String
        private var size: Size
        private var position: Point
        private var backgroundColor: Color
        private var alpha: Alpha
        
        required init(ID: String, size: Size, position: Point, backgroundColor: Color, alpha: Alpha) {
            self.ID = ID
            self.size = size
            self.position = position
            self.backgroundColor = backgroundColor
            self.alpha = alpha
        }
        
        var description: String {
            return "\(ID), \(size), \(position), \(backgroundColor), \(alpha)"
        }
    
    }
    ```

     

- 랜덤값을 생성해서 모델 생성하는 초기값을 넘겨주는 팩토리를 구현한다. 

  - Rectangle을 만드는 프로토콜을 구현하고 `RectangleFactory`가 이를 채택하는 방식으로 구현

  - 처음에는 각각 타입에 대한 생성자 `init()` 에 랜덤값으로 타입을 생성하도록 구현했는데 피드백을 받고 타입에도 각각 랜덤으로 생성할수있는 메소드를 구현하는 방식으로 변경했다. 

  - `static`으로 선언해 `Point.randomPoint()` 와 같이 접근가능하도록 구현

    ```swift
        static func randomPoint() -> Point {
            let randomX = Double.random(in: 0...900.0)
            let randomY = Double.random(in: 0...650.0)
            return Point(x: randomX, y: randomY)
        }
    ```



- print()가 아닌 시스템 로그함수로 모델 객체를 출력한다 

  ```swift
          let log = Logger()
          log.info("Rect1 : \(rect1)")
          log.info("Rect2 : \(rect2)")
  ```



![스크린샷 2022-03-07 오전 11.09.10](/Users/choeyeju/Desktop/스크린샷 2022-03-07 오전 11.09.10.png)





---


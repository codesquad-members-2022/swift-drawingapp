# swift-drawingapp

***3번째 미션 - iOS 터치 드로잉 앱*** 

- - - - 
`Step01`

- 객체지향 프로그래밍 방식으로 사각형 뷰를 표현하는 모델 클래스(class)를 설계한다.

- 필수 속성 : 
고유아이디(String), 크기(Width, Height), 위치(X, Y), 배경색(R, G, B), 투명도(Alpha)
- [X] 고유아이디는 랜덤값으로 3자리-3자리-3자리 형태
	- ID타입을 선언후 팩토리를 이용해서 생성해보았다.
    - [X] 모델 클래스 파일은 Core Graphics나 UIKit에 독립적인 타입으로 선언한다. (해당 프레임워크를 import 하지 않아야 한다)
- [X] 모델 클래스 출력을 위해서 CustomStringConvertible 프로토콜을 추가하고 구현한다.
- 
~~~swift
    struct ID:CustomStringConvertible {
    var description: String {
        "(\(firstName)-\(middleName)-\(lastName))"
    }
    
    let firstName:String
    let middleName:String
    let lastName:String
    
    
    init(firstName:String, middleName:String, lastName:String) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
    }
}
~~~

- [X] 크기는 CGSize를 사용하면 안되며, Double 타입을 기준으로 처리한다. 필요하면 Size 타입을 선언해도 된다.
- [X] 위치는 CGPoint를 사용하면 안되며, Double 타입을 기준으로 처리한다. 필요하면 Point 타입을 선언해도 된다.
- [X] 배경색도 UIColor나 CGClor를 사용하면 안되며, RGB 각각 0부터 255 사이 값으로 처리한다.
- [X] 투명도는 1-10사이값으로 10단계로 표현한다.
	- 투명도는 Int값으로 들어오게 되어있는데 init할때 10보다 큰값이나 작은값이 들어오면 어떻게 처리할지가 고민이었다.
    - 들어온 값과 실제 보여주는 값을 따로 설정해서 관리를 해보았다.
    
~~~swift
    class Alpha:CustomStringConvertible,Decoable {
    
    var description: String {
        "Alpha: \(alpha)"
    }
    
    //최소 최대값은 고정되어 있어야 하기에 let으로 선언했습니다.
    //Alpha의 min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let minValue:Int = 0
    static let maxValue:Int = 10
    
    private var inputAlphaValue:Int
    
    //투명도는 0부터 10사이가 들어와야하므로 0보다 작은 수가 들어오면 0으로 10보다 큰 수가 들어오면 10으로 변환한다.
    var alpha:Int {
        translateInputAlphaValue()
    }
    
    //alpha값을 후에 바꾸고 싶다면 현재 보이고 있는 alpha값을 빠구는게 아니라, 다시 inputValue를 이용해서 계산해야 하므로 changeAlpha메서드를 선언했다.
    func changeAlpha(to newValue:Int) {
        self.inputAlphaValue = newValue
    }
    
    //가장큰값 maxValue보다 크면 maxValue로 가작 작은값 minValue보다 작으면 minValue를 주도록 했습니다.
    private func translateInputAlphaValue() -> Int{
        
        if self.inputAlphaValue < Alpha.minValue {
            return Alpha.minValue
        } else if inputAlphaValue > Alpha.maxValue {
            return Alpha.maxValue
        } else {
            return self.inputAlphaValue
        }
        
    }
    
    init(alpha:Int) {
        self.inputAlphaValue = alpha
    }
}
~~~
    
- [X] 모델 클래스의 생성자에서 랜덤값을 처리하는 게 아니라, 랜덤값을 생성해서 모델 생성하는 초기값을 넘겨주는 팩토리를 구현한다.
~~~swift
//DrawableComponentFactory는 더이상 상속할 클래스가 없으므로 final키워드를 붙였습니다.
final class DrawableFactory:DrawableCreator {
    
    
    func makeDrawable(drawType: DrawType, horizontal:Double ,vertical:Double ) -> Drawable {
        switch drawType {
        case .point:
            return Point(x: horizontal, y: vertical)
        case .size:
            return Size(width: horizontal, height: vertical)
        }
    }
    
    func makeRandomDrawable(drawType: DrawType) -> Drawable {
        let randomHorizontal = Double.random(in: 0...Size.maxWidth)
        let randomVertical =  Double.random(in: 0...Size.maxHeight)
        
        switch drawType {
        case .point:
            let randomPoint = Point(x: randomHorizontal, y: randomVertical)
            return randomPoint
            
        //Size는 요구사항에서 고정이지만 createRandomDrawableComponent 라는 함수에서 point만 만들 수 있는것은 이상하다고 생각해서 Size도 추가했습니다.
        case .size:
            let randomSize = Size(width: randomHorizontal, height: randomVertical)
            return randomSize
        }
    }
    
}
~~~

- 추가 설명 및 참고 사이트 [참고](https://icksw.tistory.com/237)
![스크린샷 2022-03-02 오후 8 11 29](https://user-images.githubusercontent.com/80263729/156350841-385334f4-dcde-4b38-a995-83ac1dc265bf.png)

- 초기에는 이게 더 나을 거 같애라는 방식으로 접근을 했으나,
하다 보니 Protocol을 사용해보고 싶어서 만든 코드의 느낌이 강했다.
프로퍼티와 함수의 적당한 위치를 찾아 넣다보니, 심지어 프로토콜안의 내용이 텅텅비어버렸다




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


- - -

`Step2`
- [X] 생성한 사각형 객체를 포함하는 Plane 구조체를 구현한다.
- [X] Plane 구조체를 테스트하는 유닛테스트를 추가한다.

### 요구사항
- [X] 터치가 될 때마다 해당 위치에 사각형이 있다면 해당 사각형이 선택되고, 만약 사각형이 없다면 기존에 선택된 다른 사각형도 선택이 취소된다. (빈 영역을 선택할 경우만 선택 취소)

- [X] 사각형 테두리에 선을 표시해서 선택한 것을 인지할 수 있도록 한다. 사각형을 선택하면 화면 우측에 해당 사각형의 현재 배경색과 투명도가 반영된다.

- [X] 배경색 버튼에는 현재 배경색이 R-G-B 순서대로 16진수로 보이며, 버튼을 누를 때마다 랜덤한 추천 색상으로 변경한다.

- [X] 투명도는 10단계로 나눠서 변경할 수 있고, alpha값을 단계로 나눠서 적용한다.

- [X] 투명도 좌, 우에 버튼은 각각 투명도 단계를 -1, +1 시킨다. 만약 더 이상 작거나 커질 수 없으면 비활성화한다.

- 구현화면  
![Simulator Screen Recording - iPad Air (4th generation) - 2022-03-10 at 15 31 09](https://user-images.githubusercontent.com/80263729/157603298-9cf69f96-21e9-4ce6-8dc3-c65e966ed395.gif)

핵심: `입력과 출력을 구분하라!`
키워드: image configuation, tapGesture, hittest, UITouch, UIAction, Delegate, MVC
- - -
고민 및 해결
- - -
- 보통 스토리보드로 outlet과 action을 추가할때 outlet을 View안의 한 요소라고 한다면 하나의 `ViewController Class안에 View와 Controller가 다 있는 것`이라고 생각했다..
그렇다면 CustomView 클래스를 만들어서 View(outlet)와 Controller를 분리했을때 `outlet에 대한 action은 어디다가 선언해야하는가에 대한 고민`이 있었다.
공부한 바로는, View에서 사용자의 입력이 들어오면 View가 ViewController에 어떠한 변화가 있다고 알려만 주고 변화에 대해 처리하는 것은 ViewController가 해야할 일이라고 이해했으며,
따라서, CustomView클래스에 있는 각 component들에 필요한 경우 Action을 주되 `protocol과 delegate를 이용해서 처리는ViewController에서 하도록 시도`해 보았다.

- alpha값이 계속 1.0으로 나오는 오류가 있었다.
여러번의 시도끝에 모델rectangle이아니라 그, View의 alpha를 가지고왔기 때문이고
View의 alpha값은 기본값으로 1.0을 가지고있고 View안에 subView되어있는 rectangle의 alpha를 가지고 와야된다고 결론을 내렸다.
수업시간에 들었던 superView와 subView간의 alpha값 관계에 대해서 다시 복습하게 되었다.

- 생성되는 사각형들이 미리 만들어 놓은 버튼을 겹쳐서 버튼이 클릭이 안되거나 화면을 덮어버리는 경우가 생겼다.
이를 해결하기 위해 Button의 `Zposition을 1.0`으로 주었다.
하지만, 보기에는 안겹쳐보이지만 View최상단에 존재는 하는 것이므로 버튼이 클릭이 안되는 이슈는 여전히 있었다.
이를 `self.view.bringSubviewToFront()` 메서드를 통해 해결해 보았다.

- 원하던 View의 값이 바뀌거나 다시 초기화되는 문제가 생겼다.
`뷰 컨트롤러가 만들어지는 시점, AppDelegate 콜백 메소드 시점, viewDidLoad같은 콜백 메소드 호출 시점`을 확인하기 위해 간단하게 print문을 찍어 보았다.
![스크린샷 2022-03-09 오후 5 00 04](https://user-images.githubusercontent.com/80263729/157397924-6cedc5ad-a0a1-42a8-80af-e12545cb3c07.png)
![스크린샷 2022-03-08 오전 11 27 43](https://user-images.githubusercontent.com/80263729/157393672-57cb7906-89df-406b-8d99-c571d527904f.png)  
위 log과 사진을 종합해보았을떄 순서는 Appdelegate -> ViewController(init) -> SceneDelegate -> 
LoadView -> ViewDidLoad 라고 생각이되며 ViewController가 만들어지는 시점과 View가 그려지는 시점이 다르다는 것을 
알 수 있었다.
아직까지 모든 구체적인 사례는 잘 모르겠지만,  init과 loadView사이에 하나의 단계가 더있고, init할때 넣어준 값을  viewDidLoad에서 바꾼다면 결국 ViewDidLoad에서 바뀐것만 적용이 되기 때문에 init후에 다시 값을 바꾸고 싶다면 ViewDidLoad에 혹은 여러 View가 있을경우 ViewWillAppear에 로직을 적용하는게 맞다는 생각이 들었다.
	- 마스터님의 코멘트  
ViewDidLoad까지는 뷰 컨트롤러가 만들어질때 한번만 호출된다.
하지만 ViewWillAppear이후로는 여러번 불릴 수 있다.
그렇기 때문에 ViewDidLoad를 마지막 시점으로 사용되는 것이다.
ViewWillAppear에 넣으면 보일떄마다 뷰가 추가되면서 겹칠수도 있다!

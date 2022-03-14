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

- - -
`질문거리`
- 간편 생성자 vs 기존 생성자 활용
이전 피드백을 주신부분에 `RectangleView에 별다른 속성과 메서드가 없다면 기본 생성자를 활용하는 방법을 생각해보자`가 있었다.
하지만,,RetangleView는 UIView의 서브클래스이기 때문에 기존 생성자에는 init(frame:)등이 있는데
이 메서드(기존생성자)를 사용하면 init할 때 제가 정의한 Rectangle이나 RGB같은 값을 매개변수로 가지고 오는것이 힘들었다.
그렇기에, init 후에 한번더 처리해주어야 한다는 단점이 있다고 생각이 되었다.
하지만, 간편 생성자로 생성할 경우 기존 생성자와 간편생성자 모두 사용이 가능해진다.
대신,이 때 만약 기존생성자를 사용할 경우 RectangleView의 네이밍과는 다른 의미의 사각형을 만들 여지를 줄수 있다고 생각이 됬다.
따라서,RetangleViewFactory클래스를 만든다음 Static함수로 makeRetangleView를 만들어서
리턴을 하면 될거 같다는 생각을 해보았다. `Model이 아닌 View를 만드는 factory`
이후, Factory로 RectangleView를 만들고 나니 RectangleView에는 아무런 속성과 메서드가 없어서 UIView와 다를 바가 없었다
makeRetangleView메서드에서 UIView를 리턴하여 만드는 것은 이상하다고 생각이 되어 결국 원상태로 돌아왔다..

- `마스터님의 코멘트`
뷰를 생성하는데에 있어서는 항상 딜레마이다. 따라서, 이런 부분은 정답은 없고, 장단점이 있다.
그냥 View.init을 써도 되지만 이게 길어지고 처리 로직이 길어지면 귀찮아 지기때문이다.
하지만, 내가 짠 코드는 다른 사람이 사용을 할때를 생각해보아야한다.
다른 사람들은 내가 만들어놓은 간편생성자를 사용해야 한다고 생각을 못할 수 있다.
특히 UIView는 스토리보드에서 생성할 수도 있고, Xib로 만들어놓을 수도 있는데 그런 경우는 간편 생성자를 호출하지 않는다.
이런 것을 고려해보면 내가 편하자고 만들어 놓는다면 다른 사람이 전혀 사용할 수 없는 코드가 될 수 도 있다.
결론. `항상 내 코드를 나만 쓴다고 생각하지말자, 다른 환경에서도 재사용이 가능한가를 생각하자.`

- - -
`Step04`

### 학습목표
- MVC패턴에서 Model과 Controller의 직접 참조를 끊기 위해 ObserverPattern을 학습, 적용
- NotificationCenter 동작 방식을 학습, 적용

- - -
### 요구사항
- [X] Viewcontroller는 ViewDidLoad에서 observe를 등록한다

- [X] 새로운 사각형을 추가하거나 속성 바뀔 때마다 Notification을 받아서 화면을 업데이트한다.

- [X] 속성을 바꾸면 해당 모델 값이 변할 때 마다 Plane 모델 객체에서는 변화에 대해 NotificationCenter에 post한다.
- [X] 모든 동작은 이전 단계와 동일하게 동작해야 한다.사각형

- - -
- NotificationCenter
	observe하고 observer들에게 Notification을 post해주는 중간다리 역할을 하는 Center.
	observe(관찰)이라고 했지만 작동 방식을 보면 observer들이 subscrip(구독)을 하는 형태로 볼 수도 있다 왜냐하면, Post보내는 입장에서는 어떤 observer가 이 posting을 받을지 모르기 때문이다.
이때문에, Model이 ViewController에게 post해주고 ViewController가 observe하는 입장이라면
`Model은 ViewController를 몰라도 된다`, 즉 어떤 이벤트가 발생했다고 그냥 NotificationCenter에게 알려주면 NotificationCenter는 알아서 구독하고 있는 어떤한 Observer들에게 Noti를 전달할 것임.
(느슨한관계)
![](https://images.velog.io/images/seob9999/post/0e8186cc-c3ab-43bc-b60e-baec3fe08ddc/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-03-14%20%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB%209.41.19.png)
[그림출처](https://daheenallwhite.github.io/ios/2019/10/13/Notification-Center/)

- 사용법(예제코드)

`Observer로 등록하기.`
~~~swift
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(addRectangleView),
            name:Notification.Name.init(rawValue: "addRectangle"),
            object: plane )
~~~
- `default Notification Center에 observer로 add`한다.
누가? `self`== ViewController
`selector` -> 필요하다면 실행할 함수. @objc 함수가 필요하다
매개변수 타입으로 Notification을 넣어주면 notification으로 넘어 온 값을 사용 할 수있다.
~~~swift
    @objc func addRectangleView(_ notification:Notification) {
        guard let newRectangle = notification.userInfo?[Plane.UserInfoKey.addedRectangle] as? Rectangle else { return }
...
...
~~~

`name` -> 어떤 Noti를 받을 것인지에 대한 식별자이다. Post하는 쪽에서 이름을 만든다.NotificationName을 제대로 써주지 않으면 Noti를 아무리 보내도 잘 받을 수 없다.
하지만 기본 생성자를 쓰면 저렇게 하드코딩이 되어있는 것을 확인 할 수 있는데, 이 Enum이나 static let으로 그런 실수를 줄이도록 노력해보자.
`object` -> 어떤 인스턴스에서 발생하는 noti를 받을 것인지에 대한 것이다. 
따라서 이 객체에서 생기는 변화(정보)를 받을 수 있다.
예제의 plane은 Plane타입의 인스턴스인데 이를 통해서 ViewController는 모델 Plane의 인스턴스를 알고 있어야 하기 때문에(변수로 가지고 있어야하기때문에) oberve 하는 쪽(ViewController)는 posting하는 쪽(plan)을 알고 있어야한다.
`참고` 만약 object에 nil을 넣는다면, NotificationCenter에 있는 모든 Noti를 받을 수 있다. 


`Notification Post하기`
~~~swift
        NotificationCenter.default.post(
                name: Notification.Name.init(rawValue: "addRectangle"),
                object: self,
                userInfo:[Plane.UserInfoKey.addedRectangle: rectangle]
        )
~~~

- `default NotificationCenter에 post한다`
`name` Post시 정하는 Notification의 이름이자 식별자
`object` 보낼 객체 == self 즉 자기 자신을 보낸다.
이때, 중요한것은 post와 observe할때 object를 잘 구분해야 한다는 것이다.
post시 사용하는 object매개변수는 `보낼 객체` add observe시. `받을 객체`
`userInfo`:어떤 정보를 보내줄 지 key value로 이루어진 dicionary이다.
Key값으로는 Dictionary이기때문에 Hashable을 채택한 타입이라면 무엇이든 가능하다.
- `참고`: userInfo는 nil이 가능하며, object를 통해서도 정보를 전달 할 수 있긴 있다.
Ex)받는 쪽에서 object.proerty 등등.. 하지만 별로 권장되지 않는다고 한다.

- - -

`고민 및 해결`

- NotificationCenter를 사용할때 Name과 userInfo의 Key값을 하드코딩 하기 대신 Extension과 enum으로 처리를 시도했었다..
이때 NotificationCenter에 Extension을 할지 Plane에 Extension을 할지 고민이 있었고,
조원들과 공유한 결과 Plane의 Notification이기 때문에 Plane에 넣어주는것이 맞다고 생각하여 적용.

- Notification.Name과 userInfo에 들어가는 key의 네이밍을 같게 하는 편이 좋을까? 
고민끝에 Name은 말그대로 Noti의 이름이기 때문에 이 Noti의 Identity를 나타내는 것이기 때문에 어떤 변화가 일어났냐? 에초점을 두는 편으로 해보았고, userInfo에 들어가는 Key는 Value를 찾기위한 Key로 생각이 되기 때문에 Value와 관련된 네이밍을 생각해보았다.
	
   Ex) 색이 바뀌었을떄,
Noti의 이름 -> DidChangedRectangleColor (사각형의 색상이 바뀌었다)
바뀐 색상을 찾기위한 key -> changedColor (바뀐 색상은?)

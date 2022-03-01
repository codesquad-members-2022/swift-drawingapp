# swift-drawingapp 

<details>
<summary> STEP1 : 아이패드 앱 프로젝트 </summary>

## [작업 목록]
- [X] 객체지향 프로그래밍 방식으로 사각형 뷰를 표현하는 모델 클래스(class)를 설계한다
- [X] 모델 클래스 파일은 Core Graphics나 UIKit에 독립적인 타입으로 선언한다
- [X] 모델 클래스 출력을 위해서 CustomStringConvertible 프로토콜을 추가하고 구현한다
- [X] 모델 클래스의 생성자에서 랜덤값을 처리하는 게 아니라, 랜덤값을 생성해서 모델 생성하는 초기값을 넘겨주는 팩토리를 구현한다.
- [X] iOS 앱 구조는 MVC 중에서도 우선 ViewController-Model 사이 관계에 집중하고, ViewController-View 관계는 다음 단계에서 개선한다.

## [작업 기록]
 ### MVC Pattern 
  <p align="center">
   <img src="https://user-images.githubusercontent.com/36659877/155993121-8fd69fb5-fa58-4aaf-8409-a1132d6b905c.png" width="350" height="250"> 
   </p>

### Model

→ 앱의 정보, 데이터를 나타내고, 정보들의 가공을 책임지는 컴포넌트이다. 

1. 사용자가 편집하길 원하는 모든 데이터를 가지고 있어야한다. 
2. 뷰나 컨트롤러에 대해서 어떤정보도 알지 말아야한다. 
3. 변경이 일어나면, 변경 통지에 대한 처리방법을 구현해야한다. 

### View

→ 사용자에게 보여지는 모든 객체 

1. 모델이 가지고 있는 정보를 따로 저장해서는 안된다. 
2. 모델이나 컨트롤러와 같이 다른 구성요소를 알면 안된다. 
3. 변경이 일어나면, 변경 통지에 대한 처리방법을 구현해야한다

### Controller

→ 뷰와 모델을 제어하며 유저의 input 에 따라 동작함. 

1. 모델이나 뷰에 대해서 알고있어야한다. 
2. 모델이나 뷰의 변경을 모니터링 해야한다.

- 요약하면 사용자가 view 에서 어떠한 요청을 보내면 controller 는 그 요청에 맞게 model 을 통해서 데이터를 가져오고, 그 정보를 바탕으로 시각적인 표현을 담당하는 view 를 제어하여 사용자에게 전달한다. 이렇게 역할을 나누어서 프로젝트를 설계하면 각각의 역할이 뚜렷히 나누어 져있어서 코드를 수정, 관리하기 편하다. 
- 중요한 키 포인트는 “어떻게 나눌것인가” 이다. 어떤 특정한 역할들에 대해 역할부담을 할때 가이드 라인을 제시하는 방법중 하나가 바로 MVC 패턴이다.

### 미션에 MVC 패턴 적용하기 
현재 스텝에서는 Model 과 Controller 의 관계에대해서 집중적으로 다뤘다. 
Model = Rectangle, RectangleFactory
Controller = ViewController 
 ### MVC Pattern 
  <p align="center">
     <img src="https://user-images.githubusercontent.com/36659877/155999152-3ada6d67-da50-4350-8251-e000e754a5c2.png" width="550" height="500"> 
  </p>
Rectangle : 사각형에 관한 모든 속성들을 가지고 있다. 

RectangleFactory : 사각형의 모든 랜덤 값들을 생성해주고, Rectangle 을 만든다. 

ViewController : viewDidLoad 에서 4개의 사각형을 만든다.

## [추가학습]
- iOS 앱을 구성하는 핵심 객체들과 iOS 메인 런루프 동작 이해하기 위해서 애플 UIKit 설명, App and Environment 문서를 학습한다.

### [UIKit] 
- IOS 와 tvOS 의 앱에 사용되는 핵심 오브젝트들을 제공해주는 프레임워크이다. 
- 이 오브젝트들을 사용해서 스크린에 내가 원하는 내용을 보여주고 상호작용 및 관리를 할수있다.  
- UIKit 은 기본적인 앱의 동작 뿐만아니라 사용자가 원하는데로 커스터마이즈 를 할수 있는 여러 방법들을 제공해준다. 
- [Required Resources]
    - App icons 
    - Launch screen stroyboard 

- [Code Structure of a UIKit App]
    - UIKit 의 structure 는 MVC 디자인패턴으로 만들어 졌다. 
    - Model: 앱의 데이터 와 로직 을 관리한다. 
    - View : 데이터의 visual representation 을 담당한다. 
    - Controller : 모델과 뷰 오브젝트들 사이의 다리역할을 해준다. 
   <p align="center">
   <img src="https://user-images.githubusercontent.com/36659877/156154004-c959fb3f-25f2-4203-8c85-d44b7a6ca711.png" width="350" height="250"> 
   </p>
   
    - 위 그림에서 모델과 뷰의 데이터 관리를 뷰 컨트롤러와 App delegate 오브젝트들이 해주는것을 확인 할수 있다.
    - `UIApplication` 오브젝트가 앱의 메인 이벤트 loop 을 실행 하고 앱의 전반적인 생명주기를 관리한다. 
     
    

### [App and Environment]
 - [관리 목록]
 - 이벤트의 생명주기
 - UI scene 
 - `traits` of app 
 - `environment` of app 

- 프로토콜(Protocol) 역할과 표현 방식에 대해 학습한다.
### [Protocol]
    - 특정 요구사항 (구현 해야할 메소드) 들이 명시가 되어 있어서 특정 class 나 struct 들이 어떠한 프로토콜을 채택 한다는 뜻은 해당 프로토콜에 명시되어있는 기능들을 모두 구현 하겠다는 말이 된다. 

    - 한 카테고리에 속하는 Class/ Struct 들은 기본적인 기능을 모두 수행해야하는데,  프로젝트가 커질경우 이 기본적인 기능들이 너무 많아져 기능 하나하나 체크하기 힘들다. 하지만 프로토콜을 채택을 할시에 이런 불편함이 없어지고 설계했던 대로 그 카테고리의 객체들이 기본적인 기능을 갖추게 코드를 짤수 있다. 
    
- iOS13+ 이상에서 적용가능한 시스템 로그 함수를 학습한다.
### [OSLog]
    - `OSLog` 프레임워크 는 IOS14+ 적용가능한 통합 로킹 시스템이다. 
    - 통합 로깅 시스템은 데이터를 텍스트 기반 로그 파일에 쓰지 않고 메모리 및 디스크에 로그 데이터를 중앙 집중식으로 저장하는 방법인데, 이는 시스템의 모든 수준에서 원격 측정을 캡쳐할 수 있는 포괄적이고 성능이 뛰어난 API를 제공한다. 
    
    |**Level 종류**|**Disk 에 저장**|**내용**|
    |:---|:---:|:---:|
    |Default(notice)| O | 문제 해결을위한 Level |
    |Info| O | Error케이스와 유사하지만, 에러 설명이 긴 경우, 문제해걀시 활용할 수 있는, 도움이 되지만 필수적이지 않은 정보|
    |Debug| X | 개발 환경에서의 간단한 로깅 (mac의 '콘솔'앱에는 찍히지 않고 xcode console에만 표출)|
    |Error | O | Info 와 유사하지만 간단한 에러인 경우와 활동 객체가 존재하는 경우 관련 프로세스 체인에 대한 정보 캡쳐|
    |Fault | O | Error 와 유사하지만 시스템 레벨 / 다중 프로세스 오류 캡쳐를 위한 것|
    
    - `os_log()` 를 사용하여 로그 기록을 남길수 있다.
    - `os_log()` 는 Static String 을 매개 변수로 사용하는데, 문자열이 고정되어있는 형태라고 한다(바뀌지 않음). 변수 또는 상수 등의 값을 문자열 내에 나타내고 싶을 때 사용하는 문자열 보간법 `\()` 이나 `%@` 을 사용하면 사용가능하다.   
    

</details>







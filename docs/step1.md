# STEP01. 아이패드 앱 프로젝트

### 요구 사항

```bash
- [x] 객체지향 프로그래밍 방식으로 사각형 뷰를 표현하는 모델 클래스(class)를 설계한다.
  - 필수 속성 : 고유아이디(String), 크기(Width, Height), 위치(X, Y), 배경색(R, G, B), 투명도(Alpha)

- [x] 고유아이디: 랜덤값으로 3자리-3자리-3자리 형태
- [x] 크기: CGSize를 사용X. Double 타입을 기준으로 처리.(필요하면 Size 타입 선업)
- [x] 위치: CGPoint를 사용X. Double 타입을 기준으로 처리. (필요하면 Point 타입을 선언)
- [x] 배경색: UIColor나 CGClor를 사용X. RGB 각각 0부터 255 사이 값으로 처리
- [x] 투명도: 1-10사이값으로 10단계로 표현

- [x] 모델 클래스 파일은 Core Graphics나 UIKit에 독립적인 타입으로 선언한다.
(해당 프레임워크를 import 하지 않아야 한다)
- [x] 모델 클래스 출력을 위해서 CustomStringConvertible 프로토콜을 추가하고 구현한다.
- [x] 모델 클래스의 생성자에서 랜덤값을 처리하는 게 아니라, 랜덤값을 생성해서 모델 생성하는 초기값을 넘겨주는 팩토리를 구현한다.
```

### 과정

1. Color 구현 및 테스트
2. Rectangle 클래스 구현
   1. 초기화
   2. CustomStringConvertible 프로토콜 채택
   3. 랜덤 아이디 구현
3. Reactangle Factory 구현
4. OS Log 를 활용할 수 있는 싱글톤 클래스 구현

### 실행 화면

![step1실행화면](https://user-images.githubusercontent.com/12508578/156427296-1127689e-bb65-404e-8a42-75bdb9763ef2.png)

```swift
2022-03-03 03:17:52.571538+0900
DrawingApp[67508:2032564] []
[bro-qs7-9uf]: (x:0.0, y:0.0), (w:20.0,h:20.0),
(r:255,g:255,b:255), alpha:1
```

<br/>

## 배경 지식 학습

### UIColor: NSObject

> Color와 Opacity 를 저장하는 객체
> UI 요소들에 적용(label, text, background, link...)

UIKit 은 foreground, background 컬러가 적용된 color object를 제공한다.

- 제공되는 color object 는 다크모드에 자동으로 적용됨(기본값)
- 색상값을 직접 적용하거나, CGColor 를 사용하는 경우 다크 모드 변경을 직접 처리해야 한다
  - [Supporting Dark Mode in Your Interface](https://developer.apple.com/documentation/uikit/appearance_customization/supporting_dark_mode_in_your_interface) 참고

### Color init(white:alpha:)

```swift
init(white: CGFloat, alpha: CGFloat)
```

- **white**: `0.0` ~ `1.0` 사이의 그레이스케일 값
- **alpha**: `0.0` ~ `1.0` 사이의 불투명도 값

`0.0` 보다 작은 값은 `0.0`으로 해석

`1.0` 보다 큰 값은 `1.0`으로 해석

### 추상 팩토리 패턴(Abstract Factory)

추상 팩토리 패턴은 클라이언트에게 관련되거나 종속된 개체 집합을 제공하는 데 사용된다. 공장에서 생성된 객체의 "패밀리"는 런타임에 결정.

[https://github.com/ochococo/Design-Patterns-In-Swift#-abstract-factory](https://github.com/ochococo/Design-Patterns-In-Swift#-abstract-factory)

### 시스템 로그 함수(unified logging system)

> 통합 로깅 시스템
> 모든 시스템 level 에서 메시징을 캡쳐할 수 있는 고성능 API 제공

- console.app 을 이용해 로깅가능하다.

```swift
os_log("안녕 OS!", type: .default)
os_log("이건 에러", type: .error)
 // 하위시스템, 카테고리에 추가 정보를 입력할 수 있다.
//Jin.com.DrawingApp
let osLog = OSLog(subsystem: "jin", category: "HELLO")
os_log("HELLO 로그", log: osLog)
```

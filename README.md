# swift-drawingapp

> 드로잉 앱 부터는 미리 README에 해야 할 일을 짜놓고 시작하기로 하였습니다.
> 작업부터 하고 README를 작성하고 있다보면 잊어버린 것을 발견하게 되어 버려서 아무래도 이 편이 나을 것 같습니다.

## Step1 - 아이패드 앱 프로젝트

### 학습 목표

```
MVC 구조를 학습한다.
View Factory 방식의 뷰 생성방식을 실습한다.
MVC 구조에 객체지향 프로그래밍 방식을 섞어 학습한다.
```

### 작업 목록

- [x] (Git) 저장소 fork 및 clone 후 작업 branch 생성

```View 구간:point_down:```

- [x] 사각형(뷰)을 만드는 모델을 생성한다. Class를 사용하고 Core Graphics나 UIKit을 임포트 하지 않는다.
- [x] CGSize/CGPoint를 사용하지 않고 Double타입을 기준으로 처리한다. Size/Point 타입을 선언해도 된다.
- [x] UIColor/CGColor를 사용하지 않고 RGB를 이용하여 처리한다.
- [x] 투명도를 1-10사이의 랜덤 값으로 표시한다.
- [x] CustomStringConvertible 프로토콜을 추가해본다.

```View Controller 구간:point_down:```

- [ ] 사각형(뷰)을 뷰에 추가하는 뷰컨트롤러를 생성한다.
- [x] 모델을 생성할 때 랜덤값을 보내주는 팩토리 메소드를 생성한다. 모델은 랜덤값을 생성하지 않는다.

```View-View Controller 구간:point_down:```

- [ ] View-ViewController 간의 관계가 명확히 드러나도록 구현한다.

### 추가로 진행한 사항
- [ ] 접근제한자 처리
- [ ] 객체 간 역할 분담
- [ ] 테스트에 맞게 메소드 수정

<img src="DrawingApp/IMAGES/Model_ViewController.jpg" alt="Model_ViewController" width="350" />

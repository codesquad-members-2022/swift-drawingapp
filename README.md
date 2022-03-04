# swift-drawingapp
## 작업내역

| 날짜       | 번호   | 내용                             | 비고                                             |
| ---------- | :----- | ------------------------------| ---------------------------------------------- |
| 2022.03.04 | Step02 | 속성 변경 동작                   | 사각형 속성 조정 컨트롤 뷰 및 관련 기능 구현              |
| 2022.02.28 | Step01 | 아이패드 앱 프로젝트               | 사각형 View 랜덤 생성 관련 Model, VC 구현             |

------
## [Step02] 
### Description
- 선택한 사각형의 속성 값들을 보여주고 슬라이더를 통해 속성 값을 변경해주는 기능 구현

### Task
- [x] 사각형의 속성 값을 출력하고 조정하는 하위 뷰들을 가지는 RightAttributerView 구현
    - [x] RGB 값, Alpha 값을 출력하는 Label과 값을 조정할 수 있는 Slider 구현
    - [x] Custom Delegate 구현을 통해 VC와 연결
    - [x] addTarget을 통해 슬라이더 액션 연결
- [x] RectangleArray 클래스를 Plane 구조체로 변경
    - [x] Rectangel의 인스턴스들을 소유하고 서칭이 가능한 구조로 수정
- [x] VC에 GestureRecognizerDelegate 구현
    - [x] 선택된 View의 좌표 값이 포함된 Rectangle 인스턴스를 Plane에서 서칭하는 로직 구현
    - [x] 사각형 View와 Rectangle이 일치하면 RigthAttributerView의 label과 slider의 출력 값들의 변경 지시
- [x] VC에 RightAttributerViewDelegate 구현
    - [x] slider의 값 변경 시, Rectangle과 사각형 View, RigthAttributer 내부 view들의 값 변경 지시
    
### 결과 화면
- 정상 작동.gif
<img src = "https://user-images.githubusercontent.com/44107696/156721736-c80df1c8-6aba-4f4c-a896-c6b2a78193ca.gif" width="710" height="570">


------
## [Step01] 
### Description
- 랜덤으로 사각형을 만드는 모델들과 이를 화면에 구현하는 VC 로직 구현

### Task
- [x] UIView에 부여할 속성 값들을 지닌 Rectangle 클래스 설계
    - [x] 내부 프로퍼티의 타입들을 커스텀으로 지정 (Attributes 파일 내에 모음)
    - [x] CustomStringConvertible 구현
    - [x] 프로퍼티 접근은 메서드를 통해서만 가능하도록 구현
- [x] Rectangle의 초기값을 랜덤으로 생성해서 넘겨주는 RectangleFactory 클래스 설계
    - [x] 직접 인스턴스 생성해주는 게 아닌, 메서드를 통해 각각의 프로퍼티에 들어갈 초기값을 리턴
- [x] 생성된 Rectangle의 인스턴스들을 담는 RectangleArray 클래스 설계
    - [x] RectangleFactory를 활용하여 Rectangle 인스턴스를 생성
    - [x] 방금 생성된 Rectangle 인스턴스를 리턴하는 함수 구현
- [x] Rectangle 생성 액션 로직을 담을 Button 추가
    - [x] 혹여 생성된 Rectangle이 없을 경우 Alert 출력 구현

### 결과 화면
- 정상 작동.gif
<img src = "https://user-images.githubusercontent.com/44107696/155989496-3ae6b336-ddaa-435a-8de3-1fc4e377d53d.gif" width="800" height="790">

- Rectangle 미생성.gif
<img src = "https://user-images.githubusercontent.com/44107696/155989901-381ae318-771d-49ca-9d17-d2dbfa070af9.gif" width="710" height="560">

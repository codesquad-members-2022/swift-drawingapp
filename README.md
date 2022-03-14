# swift-drawingapp
## 작업내역

| 날짜       | 번호   | 내용                             | 비고                                             |
| ---------- | :----- | ------------------------------| ---------------------------------------------- |
| 2022.03.14 | Step05 | 터치와 드래그                    | 추가된 View들에 대한 드래그 기능 구현                   |
| 2022.03.11 | Step04 | 사진 추가하기                    | UIImagePickerController를 활용한 앨범 사진 View 추가  |
| 2022.03.08 | Step03 | 관찰자(Observer) 패턴 적용        | Step02 단계에서 구현한 기능 Observer패턴과 결합         |
| 2022.03.04 | Step02 | 속성 변경 동작                   | 사각형 속성 조정 컨트롤 뷰 및 관련 기능 구현              |
| 2022.02.28 | Step01 | 아이패드 앱 프로젝트               | 사각형 View 랜덤 생성 관련 Model, VC 구현             |

------
## [Step05] 
### Description
- 추가된 View들에 대해서 드래그 기능 구현 

### Task
- [x] PangGestureRecognizer를 활용하여 드래그 기능 구현
- [x] 드래그 시, 투명도 0.5의 임시 뷰 생성
- [x] 생성된 임시뷰가 드래그에 맞춰서 이동 진행
- [x] 드래그를 마치면 임시뷰 삭제 후, 해당 위치로 실제 뷰가 이동
    -[x] 내부 데이터의 Point도 동시 변경
- [x] 드래그 관련 메서드를 가진 ViewDragable 프로토콜 작성
    
### 결과 화면
- 정상 작동.gif
<img src = "https://user-images.githubusercontent.com/44107696/158097368-6fd0e3ac-a4ea-480f-91d6-4aeded158269.gif" width="710" height="570">


------
## [Step04] 
### Description
- 앨범에서 선택한 사진이 View에 추가되도록 구현 

### Task
- [x] UIImagePickerController 사용
- [x] Image 관련 모델 생성 및 Image/Model의 부모클래스 RectValue 작성
- [x] Plane이 관리하는 타입을 RectValue로 변경
    
### 결과 화면
- 정상 작동.gif
<img src = "https://user-images.githubusercontent.com/44107696/157814831-7344e692-924e-493f-9b53-d3d6644bab9e.gif" width="710" height="570">


------
## [Step03] 
### Description
- 기존 기능들을 유지하며 Observer 패턴 적용

### Task
- [x] Observer 패턴 적용
    - [x] Model - VC 간에 NotificationCenter를 활용하여 패턴 적용
    - [x] Notification.Name 설정 및 userInfo 활용
    - [x] View - VC는 Delegate 패턴 유지
- [x] extension을 활용하여 기능 별로 분할 정리
- [x] 전반적인 로직 개선
    
### 결과 화면
- 정상 작동.gif
<img src = "https://user-images.githubusercontent.com/44107696/156959735-2c319771-b731-44ad-be14-ce12e09642a0.gif" width="710" height="570">


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

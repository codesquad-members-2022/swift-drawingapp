# STEP02. 속성 변경 동작

### 요구 사항

- [x] 사각형 생성 버튼 터치시, 사각형을 화면에 그리기
- [x] 새로운 사각형을 Plane(Model)에 추가
- [x] 터치한 영역에 사각형이 있는지 판단
- [x] 터치한 사각형을 정보 화면에 띄우기
- [ ] Subscript 로 index를 넘기면 해당 사각형 모델 return
- [ ] 투명도: 10단계. +,- 버튼으로 단계 변경

### 과정

1. 사각형 만들기 버튼 터치시 팩토리에서 모델 객체 생성
   - 생성한 Rectangle을 화면에 그리기
   - 생성한 Rectangle에 탭 제스쳐 붙이기(사각형 터치시 정보를 보여주기 위함)
2. 화면을 Touch했을때, 모델에게 Point를 넘겨 사각형이 있는지 판단
   - 사각형이 있다면, 해당 정보를 정보화면에 뿌려주기
3. 정보 화면(InputView) 를 하위뷰로 분리
4. 사각형을 화면에 그리기 위한 커스텀뷰-RectangleView 구현
5. 생성한 Rectangle 들을 담는 Dictionary 구현
   - `private var rectangles = [Rectangle: RectangleView]()`
   - 선택한 Rectangle 의 정보는 이제 Dictioanry로 들고 있으므로, Rectangle 에 붙인 탭 제스쳐 코드 제거
6. (진행중) 선택한 사각형의 정보를 Plane(Model) 에서 들고 있도록 변경

### 실행 화면

![step2실행화면](https://user-images.githubusercontent.com/12508578/157358651-f1e384f5-f60f-4729-9624-ea129aa695e3.png)

<br/>

## 배경 지식 학습

### xib 커스텀 뷰: File’s Owner VS Custom Class

> xib 로 커스텀 뷰 생성시, 연결하는 2가지 방법

CustomView.xib 파일에서

1. **Placeholders → File’s Owner**
   - File’s Owner 에서 .swift 파일을 연결한다
     - xib 를 소유할 class 타입을 지정한 것 (IBOutler, IBAction 연결을 위함)
   - 뷰를 가져오기 위해 .swift 파일에서 nib 형태로 불러온다
2. **View → Custom Class**

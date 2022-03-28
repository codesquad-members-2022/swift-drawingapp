# iOS - DrawingApp



## Step5. 드래그 기능 구현

### :pushpin:주요 작업 내용

- [x] X값 증가, X값 감소, Y값 증가, Y값 감소, Width값 증가, Width값 감소, Height값 증가, Height값 감소 버튼 추가
- [x] 해당 버튼이 눌려질 때 호출될 액션 메서드들 정의
	- [x] 해당 액션 메서드에서 사용할 Plane의 `changePoint(to:)`, `changeSize(to:)` 메서드 구현

- [x] 사각형뷰가 움직일 때마다 X,Y Label의 Text가 해당 사각형뷰의 좌표를 보여주는 기능을 하도록 설정
- [x] DrawableAreaView을 ViewController로부터 분리
- [x] 앱 아이콘, 슬라이더바 색상 변경


---

### :computer:작업 진행과정

1. X값 증가, X값 감소, Y값 증가, Y값 감소, Width값 증가, Width값 감소, Height값 증가, Height값 감소, 총 8개의 버튼을 Storyboard를 이용해 생성하고, ViewController의 액션 메서드들과 연결
	1. 해당 액션 메서드들이 Plane에게 지시할 때 사용하는 `changePoint(to:)`, `changeSize(to:)` 메서드를 구현하고, 해당 메서드 내에서 변경됐음을 노티를 날리도록 설정
	2. ViewController에서는 해당 노티를 받아, 뷰의 좌표나 사이즈를 수정하도록 흐름을 만듦

2. 사각형 모델의 X, Y 좌표와 Width, Height 크기를 나타내는 Label 4개도 추가하여 ViewController의 아울렛 변수와 연결
	1. ViewController에서 Plane으로부터의 모델의 속성이 변경됐음을 알리는 노티를 받으면 해당 모델의 속성을 해당 label에 표시하는 기능 추가

3. 사각형 뷰를 pan Action을 이용해 이동시킬때 변화하는 위치를 X Label, Y Label에서 확인할 수 있는 기능 추가
4. DrawableAreaView를 ViewController로부터 분리하여, 해당 위치에서 발생하는 이벤트를 DrawableAreaView가 ViewController에게 전달하고, 해당 위치에 있는 뷰들의 업데이트는 ViewController가 DrawableAreaView에게 지시하도록 흐름 수정
	1. 또한 pan Action을 통한 뷰의 이동이 발생할때 Label에 좌표를 표시하는 기능을 위해, DrawableAreaViewDelegate 프로토콜을 선언하여 뷰의 이동에 대한 내용을 ViewController가 알 수 있도록 흐름 수정

5. 사각형 모델의 X, Y, Width, Height 값의 최솟값(1.0)을 설정하여, 그 이하로는 버튼을 이용해 이동시키거나 Resize할 수 없도록 제한 추가
6. Refactoring
	1. 클래스의 이름이 프로토콜과 구분이 잘 되도록, AnyRectangularable 클래스의 이름을 BasicShape로 수정
	2. DrawableAreaView 내에 외부에서 호출될 경우 문제가 발생할 수도 있는 메서드들의 접근 제어자를 private로 수정
	3. 거대해진 프로토콜을 기능에 따라 분리
	4. pan Action으로 뷰를 이동시킬 때에도 최솟값 이하로 뷰를 이동시키지 못하도록 하는 기능 추가


>완성 일시: 2022.03.28 21:59

---

### :clipboard:프로그램 동작 화면

1. `사각형 생성` 에 해당하는 버튼을 누르면 임의의 좌표에 임의의 배경색, 임의의 투명도를 가진 사각형이 생성됩니다.
2. 생성된 사각형을 터치하면 오른쪽의 `배경색 버튼` 과 `투명도 조절 버튼`, 그리고 `투명도 조절 슬라이더` 가 활성화됩니다.
	1. `배경색 버튼`을 누르면 선택된 사각형의 **배경색**이 랜덤으로 변경됩니다.
	2. `투명도 버튼`을 누르거나, `투명도 슬라이더` 를 조절하면 선택된 사각형의 **투명도**가 변경됩니다.
3. 빈공간을 터치하면 오른쪽의 버튼, 슬라이더가 비활성화됩니다.
4. `사진 생성` 에 해당하는 버튼을 누르면 ImagePicker가 등장하게 되고, 이미지를 선택한 후 `Use` 버튼을 누르면 임의의 좌표에 임의의 투명도를 가진 사진 사각형이 생성됩니다.
5. 생성된 사진 사각형을 터치하면 오른쪽의 `투명도 조절 버튼`, `투명도 조절 슬라이더`가 활성화되고, `배경색 버튼`은 비활성화(숨겨짐) 됩니다.
	1. `투명도 버튼`을 누르거나, `투명도 슬라이더`를 조절하면 선택된 사각형의 **투명도**가 변경됩니다.
6. 두 손가락을 이용해 사각형을 이동시킬 수 있습니다.
	1. 이동 시에는 선택된 뷰를 임시로 복사하여 움직임을 볼 수 있고, 이동이 끝나면 복사된 뷰는 제거되고 선택된 뷰가 해당 위치로 이동합니다.
7. 우측의 위치, 크기 버튼을 이용해 선택된 뷰의 위치와 크기를 단계적으로 조정할 수 있습니다.
	1. 단, X, Y, Width, Height 의 최솟값은 1.0 으로 그 이하로 수정할 수 없습니다.



![SS 2022-03-18 PM 04 45 04](https://user-images.githubusercontent.com/92504186/158958618-ca6b9c28-2ca7-4a9a-bf03-0ed04c6ec47a.gif)
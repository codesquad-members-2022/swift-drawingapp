# iOS - DrawingApp



## Step4. 사진 추가하기

### :pushpin:주요 작업 내용

- [x] 사진을 ImagePicker로부터 불러와 추가할 수 있는 기능 추가
- [x] 사진을 처리하는 Photo 클래스와 PhotoView 클래스 선언
- [x] Rectangle, Photo의 부모 클래스로 사용할 AnyRectangularable 클래스 선언
- [x] Rectangularable 프로토콜을 역할을 기준으로 분리하여, BackgroundColorChangable, ImageDataHavable 프로토콜 추가로 선언
- [x] 추가적으로 추상 타입을 의존할 수 있도록 일부 변경

---

### :computer:작업 진행과정

1. 사진을 추가해주는 새로운 버튼을 추가하는 메서드 선언
2. 사진을 처리해주는 Photo 클래스와 PhotoView 클래스 선언
	1. Photo 클래스에서는 ImagePicker로 가져온 사진을 Data 타입 형태로 저장하도록 설정
	2. 해당 클래스들을 생성해주는 팩토리 메서드 선언
	3. Plane에서 Photo 객체를 추가하는 `addNewPhoto(in:with:)` 메서드 선언
3. ViewController에서, 사진 추가 버튼의 입력을 받으면 Plane 인스턴스에게 addNewPhoto(in:with:)을 지시하고, 새로운 Photo 객체가 생성되면 그 객체와 PhotoView를 연결시켜주고 연결된 PhotoView를 화면에 보여주는 흐름 생성
	1. ViewController가 UIImagePickerControllerDelegate, UINavigationControllerDelegate 프로토콜을 채택하도록 확장
	2. ViewController에서 Photo객체가 Plane에 추가된 것을 노티받는 옵저버 추가
	3. 해당 옵저버를 통해 노티받으면 실행되는 메서드 `planeDidAddPhoto(_:)` 메서드 추가
4. Rectangle, Photo 클래스의 부모 클래스 AnyRectangularable 클래스 선언
	- 해당 클래스를 이용해 Rectangle, Photo를 다룰 때 조금 더 추상 타입으로 다룰 수 있도록 설정
5. Refactoring
	1. Rectangularable 프로토콜을 역할을 기준으로, BackgroundColorChangable, ImageDataHavable 프로토콜로 분리하여 Rectangle, Photo 클래스가 각각의 프로토콜을 채택하도록 설정
	2. 사진이 터치됐을 경우 배경색 버튼을 비활성화하기 위해 프로토콜에 선언해주었던 메서드/프로퍼티를 제거하고, userInfo를 통해 받아온 객체의 타입 캐스팅 가능 여부를 이용해 배경색 버튼의 활성/비활성 판단하도록 수정 (타입이 추가될 때마다 메서드/ 프로퍼티를 기존의 프로토콜/ 객체에 추가하면 매번 객체가 변경되어야 하니, 이런 방법보다는 추상 타입으로의 타입 캐스팅 가능 여부를 이용해 결정되도록 수정)

>완성 일시: 2022.03.15 19:00

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

<img src="https://user-images.githubusercontent.com/92504186/158357858-ce55dab4-81bb-456e-b9dc-2c50a73aecc5.gif" alt="SS 2022-03-15 PM 07 25 23" width="50%;" />
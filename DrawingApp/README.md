# KPT 회고 앱
by Eddy


## Step 1. 사각형 객체 설계

**Screenshot**
![step1_1](https://user-images.githubusercontent.com/17468015/156973068-df1d1ae6-10c4-4a2b-b10a-c9123a0aa4ab.png)

**주요 기능**
- 팩토리에서 Rectangle 객체 를 생성하고, 시스템 로그 함수로 출력한다.

**완료 일자**
2022.03.01

## Step 2. 사각형 추가, 선택, 변경

**Screenshot**

![step2](https://user-images.githubusercontent.com/17468015/156528888-ed8208ed-dca1-4c15-86a6-86517a3d8135.gif)

**주요 기능**
- 시작 시 4개의 랜덤 사각형을 추가한다.
- '사각형 추가'를 누르면 랜덤 사각형이 추가된다.
- 사각형을 탭하면 선택되고 테두리 모양이 바뀐다.
- 선택된 사각형의 속성이 측면 패널에 보인다.
- 패널에서 사각형의 속성을 바꾸면 사각형 색깔과 투명도가 변한다. 

**완료 일자**
2022.03.03

## Step 3. Observer 패턴 적용

**Screenshot**

![step3](https://user-images.githubusercontent.com/17468015/156721080-a82e45de-b4a4-434e-b78a-280596b8e00d.gif)

**주요 기능**
- 기능은 그대로 유지.

**변경 사항**
- ViewController - Model 간의 Delegate 패턴을 모두 제거.
- ViewController (Canvas) - ViewController (Panel) 간의 직접 연결도 제거. 
- Notification Center를 통해, Model과 Control 변화를 Canvas ViewController가 관찰하도록 수정

**완료 일자**
2022.03.04

## Step 4. 사진 추가 기능 & Photo 모델 추가

**Screenshot**

![step4](https://user-images.githubusercontent.com/17468015/156972996-d4d6341f-b954-4b31-be7f-6d33b9a04f73.gif)

**주요 기능**
- 사진 추가 버튼을 누르면 Image Picker가 등장
- 사진을 선택하면 Photo Model을 생성하고 변화를 Canvas에 업데이트
- Photo의 경우, Color 속성이 없기 때문에 Panel에서 Color가 Disabled.

**완료 일자**
2022.03.07


## Step 5. 드래그 기능

![step5](https://user-images.githubusercontent.com/17468015/157000787-c752f420-b6d7-4f26-bf3d-17f9a0e108c8.gif)

**주요 기능**
- 손가락을 터치하면 사각형, 사진 모두 드래그가 가능하다.
- 드래그 하는 동안 투명도와 그림자가 들어간 임시 뷰를 표시한다.
- 드래그가 끝나면 임시 뷰는 사라지고 선택 뷰가 해당 위치로 이동한다.

**완료 일자**
2022.03.07

## Step 6. 크기, 위치 조절 기능

![step6](https://user-images.githubusercontent.com/17468015/157672804-2acadf8a-73aa-49df-bd66-118dcecadedc.gif)

**주요 기능**
- 사각형/사진을 선택하면 위치와 크기가 패널에 보여진다.
- 패널을 사용해 선택된 뷰의 크기와 위치를 조절할 수 있다.
- 크기 조절 시 비율 고정을 설정할 수 있다.
- 드래그 시 임시 뷰의 위치 정보를 패널에 표시한다.

**완료 일자**
2022.03.10

## Step 7. 텍스트 레이블 추가 & 수정 기능

![step7](https://user-images.githubusercontent.com/17468015/157873716-d914a680-8141-47ff-8c40-f533a4a6eede.gif)

**주요 기능**
- 텍스트 버튼을 누르면 랜덤한 레이블이 추가된다.
- 레이블을 선택하면 패널에 위치, 크기, 텍스트가 보여진다.
- 패널을 사용해 레이블의 위치, 크기, 텍스트를 수정할 수 있다.
- 레이블의 크기는 텍스트의 고유 콘텐츠에 맞게 계속 재설정된다.

**완료 일자**
2022.03.11

## Step 8. 레이어 목록 표시 & 조작 기능

![step8](https://user-images.githubusercontent.com/17468015/158596255-b994905d-748f-4a1d-ad14-37a3ffde69fc.gif)

**주요 기능**
- 새로운 레이어가 추가될 때 리스트에 표시한다.
- 리스트를 터치하면 해당하는 레이어를 선택하고, 한번 더 터치하면 해제한다.
- 리스트를 2초 이상 길게 터치하면 순서를 조정하는 메뉴를 띄운다.
- 리스트를 드래그하면 순서를 바꿀 수 있다.

**완료 일자**
2022.03.16

## Step 9. 포스트잇 기능 추가

![step 9](https://user-images.githubusercontent.com/17468015/160514732-5f9ba8e3-165b-46ea-bb91-ff21f274aa46.png)

**주요 기능**
- 포스트잇을 추가할 수 있다.


## Step 10. MVVM 구조로 리팩토링

![step 10_diagram](https://user-images.githubusercontent.com/17468015/160744862-d62e975b-e2b3-4be4-8da2-b33a9c6f8445.png)

![step 10](https://user-images.githubusercontent.com/17468015/160741515-478563d0-e784-48fa-965c-2da00efa6735.png)


## Step 11. 의존성 역전, 의존성 주입을 위한 컨테이너 추가

![step 11_diagram](![Screen Shot 2022-03-31 at 4 06 10 PM](https://user-images.githubusercontent.com/17468015/160997465-fe851675-028f-4738-951c-d5d31beb7d22.png)

- Logic, Model 레이어에 프로토콜을 추가해 의존성 역전
- 의존성 주입을 위한 DIContainer 구현
- 설정한 DIConainter를 SceneDelegate에서 ViewController까지 전달

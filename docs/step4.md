# 사진 추가하기

## 작업 목록

- [x] 이미지 추가 버튼
- [x] 버튼 이미지 적용 및 corner radius 부분 적용
- [x] 사각형 추가 시 scale 애니메이션 효과 추가
- [x] RectangleView 를 UIImageView 상속하게 변경
- [x] 앨범에서 선택한 이미지를 화면에 표시
- [x] 표시된 이미지의 투명도 값 변경
- [x] 사진데이터 처리 관리 뷰 또는 뷰 모델 선언

## 데모

<image src="../images/step4.gif" width="300px">

## 학습 키워드

- OptionSet
- UIView.animate
- UIButton.Configuration
- DispatchGroup
- UTType
- PHPickerViewController & PHPickerViewControllerDelegate

## 고민

- 앨범에서 여러 이미지(최대 3장) 선택 후 사각형이 화면에 표시될 때 동시에 표시되지 않는 문제가 발견되었습니다.
- 현재 동기적으로 이벤트를 처리하게 되어 있는 NotificationCenter 가 원인이라는 생각이 들었습니다.
- NotificationCenter 를 비동기적인 흐름을 처리하도록 바꾸어 개선해볼 생각입니다.

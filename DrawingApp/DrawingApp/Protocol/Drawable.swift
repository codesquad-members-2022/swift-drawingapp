//
//  Drawable.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/02.
//

//Size와 Point모두 Double값을 두개 갖는다는 것을 바탕으로 시도했으나, 생성시 타입별 두 Double 변수명이 같으니 이상한 것 같아 뺏습니다.
//Draw라는 함수를 임시적으로 구현해서 값이 잘나오는지 확인했습니다.
protocol Drawable {
    func draw()
}

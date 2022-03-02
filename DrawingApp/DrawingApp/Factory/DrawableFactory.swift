//
//  DrawableComponentFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/02.
//

//DrawableComponentFactory는 더이상 상속할 클래스가 없으므로 final키워드를 붙였습니다.
final class DrawableFactory:DrawableCreator {
    
    
    func makeDrawable(drawType: DrawType, horizontal:Double ,vertical:Double ) -> Drawable {
        switch drawType {
        case .point:
            return Point(x: horizontal, y: vertical)
        case .size:
            return Size(width: horizontal, height: vertical)
        }
    }
    
    func makeRandomDrawable(drawType: DrawType) -> Drawable {
        let randomHorizontal = Double.random(in: 0...Size.maxWidth)
        let randomVertical =  Double.random(in: 0...Size.maxHeight)
        
        switch drawType {
        case .point:
            let randomPoint = Point(x: randomHorizontal, y: randomVertical)
            return randomPoint
            
        //Size는 요구사항에서 고정이지만 createRandomDrawableComponent 라는 함수에서 point만 만들 수 있는것은 이상하다고 생각해서 Size도 추가했습니다.
        case .size:
            let randomSize = Size(width: randomHorizontal, height: randomVertical)
            return randomSize
        }
    }
    

}

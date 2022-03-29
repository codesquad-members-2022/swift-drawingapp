//
//  Plane.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/08.
//

import Foundation
import UIKit

class Plane {
    var delegate: PlaneDelegate?
    
    private(set) var rectangles = [Rectangle]()
    private var selectedRectangle: Rectangle?
    var rectangleCount: Int {
        return rectangles.count
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    func createRectangle() {
        let factory = RectangleFactory()
        let rectangle = factory.createRectangle()
        rectangles.append(rectangle)
        
        // NotificationCenter로 Notification 전달
        NotificationCenter.default.post(name: NSNotification.Name.PlaneDidCreateRectangle, object: self, userInfo: [UserInfoKeys.rectangle: rectangle])
    }
    
    
    /// 터치된 좌표에 사각형의 유무 탐색 (Plane이 직접 하는 일)
    /// - Parameter point: 터치된 좌표
    /// - Returns: 사각형이 있으면 사각형, 없으면 nil.
    private func findRectangle(on point: (x: Double, y: Double)) -> Rectangle? {
        for rectangle in rectangles.reversed() {
            if isRectangleExist(on: point, rectangle: rectangle) {
                return rectangle
            }
        }
        return nil
    }
    
    // rectangle 속성이 아닌 Plane 내부 속성과 관련 있도록 구현하기.
    private func isRectangleExist(on point: (x: Double, y: Double), rectangle: Rectangle) -> Bool {
        let startPointOfX = rectangle.point.x
        let endPointOfX = startPointOfX + rectangle.size.width
        let startPointOfY = rectangle.point.y
        let endPointOfY = startPointOfY + rectangle.size.height
        return (startPointOfX...endPointOfX).contains(point.x) && (startPointOfY...endPointOfY).contains(point.y)
    }
    
    private func backgroundColorDidChanged(color: Color, rectangle: Rectangle) {
        if let firstIndex = rectangles.firstIndex(of: rectangle) {
            rectangles[firstIndex].backgroundColor = color // 색상 변경
        }
    }
    
    /// View에서 터치된 좌표를 VC를 통해 얻어옴. (입력 처리)
    /// 선택된 좌표에 직사각형이 있는지 확인하기 (모델이 직접 함)
    func didTouched(on point: (x: Double, y: Double)) {
        guard let rectangle = findRectangle(on: point) else {
            selectedRectangle = nil
            delegate?.planeDidTouchedEmptySpace() // 출력: Model -> VC (빈 공간 터치 알림)
            return
        }
        
        selectedRectangle = rectangle
        
        // selectedRectangle이 있으면, 이걸 통해 이제 출력을 해줘야한다. (Plane -> VC -> View)
        delegate?.planeDidTouchedRectangle(rectangle)
    }
    
    /// VC로부터 색상 버튼이 탭되었음을 전달받았기 때문에, 랜덤 색상을 생성하여 모델을 변경 후 이를 VC에 알린다.
    func changeBackgroundColor() {
        let rectangeFactory = RectangleFactory()
        let newColorValue = rectangeFactory.createRandomColor()
        
        // 선택된 사각형이 있을 때에만 색상 변경
        if let rectangle = selectedRectangle {
            backgroundColorDidChanged(color: newColorValue, rectangle: rectangle)
            
            // VC에게 색상 변경된 사각형 알리기
            delegate?.planeDidChangedColor(of: rectangle)
        }
    }
    
    /// VC로부터 투명도 변경되었음을 전달받았기 때문에, 모델의 투명도를 변경하고 이를 VC에 알린다.
    func changeAlphaValue(alpha: Float) {
        for rect in rectangles.reversed() {
            if rect == selectedRectangle {
                // 투명도 변경
                rect.alpha = Alpha(rawValue: Int(alpha * 10))!
                delegate?.planeDidChangedAlpha(of: rect)
            }
        }
    }
}

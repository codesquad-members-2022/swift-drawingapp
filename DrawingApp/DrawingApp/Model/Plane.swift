//
//  Plane.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/08.
//

import Foundation
import UIKit

struct Plane {
    var delegate: PlaneDelegate?
    
    private(set) var rectangles = [Rectangle]()
    private var selectedRectangle: Rectangle?
    var rectangleCount: Int {
        return rectangles.count
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    mutating func createRectangle() {
        let factory = RectangleFactory()
        let rectangle = factory.createRectangle()
        rectangles.append(rectangle)
        
        delegate?.planeDidAddRectangle(rectangle)
    }
    
    
    /// 터치된 좌표에 사각형의 유무 탐색 (Plane이 직접 하는 일)
    /// - Parameter point: 터치된 좌표
    /// - Returns: 사각형이 있으면 사각형, 없으면 nil.
    private func findRectangle(on point: (x: Double, y: Double)) -> Rectangle? {
        for rectangle in rectangles.reversed() {
            if isRectangleExist(on: (x: point.x, y: point.y), rectangle: rectangle) {
                return rectangle
            }
        }
        return nil
    }
    
    private func isRectangleExist(on point: (x: Double, y: Double), rectangle: Rectangle) -> Bool {
        let rangeOfX = (rectangle.point.x)...(rectangle.point.x + rectangle.size.width)
        let rangeOfY = (rectangle.point.y)...(rectangle.point.y + rectangle.size.height)
        return (rangeOfX ~= point.x && rangeOfY ~= point.y)
    }
    
    private func backgroundColorDidChanged(color: Color, rectangle: Rectangle) {
        if let firstIndex = rectangles.firstIndex(of: rectangle) {
            rectangles[firstIndex].backgroundColor = color // 색상 변경
            delegate?.planeDidChangedRectangle(rectangles[firstIndex])
        }
    }
    
    func alphaValueDidChanged(alpha: Float, rectangle: Rectangle) {
        for rect in rectangles.reversed() {
            if rect == rectangle {
                // 투명도 변경
                rect.alpha = Alpha(rawValue: Int(alpha * 10))!
                delegate?.planeDidChangedRectangle(rect)
            }
        }
    }
    
    /// View에서 터치된 좌표를 VC를 통해 얻어옴. (입력 처리)
    /// 선택된 좌표에 직사각형이 있는지 확인하기 (모델이 직접 함)
    mutating func didTouched(on point: (x: Double, y: Double)) {
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
            
            // VC에게 알리기
            delegate?.planeDidChangedColor(newColorValue)
        }
    }
}

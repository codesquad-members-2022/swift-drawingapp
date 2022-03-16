//
//  RectangleProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation

/// 사각형 모델 클래스를 추상화 하는 공통 모델 클래스
///
/// 기존에 화면에 나오는 사각형을 담당하였지만 현재는 모든 Rectangle 모델 클래스를 추상화합니다.
class RectangleProperty: RectanglePropertyCreator {
    
    let name: String
    let id: String
    
    private(set) var size: RectSize
    private(set) var point: RectOrigin
    
    private(set) var alpha: Double
    
    private(set) var backgroundImageData: Data?
    
    init(as name: String, using id: String, from screenRect: ScreenSceneRect, alpha: Double) {
        self.name = name
        self.id = id
        self.point = RectOrigin(x: screenRect.maxX, y: screenRect.maxY)
        self.size = RectSize(width: screenRect.width, height: screenRect.height)
        self.alpha = alpha
    }
    
    // MARK: - Setter/Getter in model
    
    @discardableResult
    func setAlpha(_ alpha: Double) -> Bool {
        guard alpha >= 0 else { return false }
        self.alpha = alpha
        return true
    }
    
    @discardableResult
    func setSize(_ size: RectSize) -> Bool {
        guard size.width >= 0 || size.height >= 0 else { return false }
        self.size = size
        return true
    }
    
    @discardableResult
    func setPoint(_ point: RectOrigin) -> Bool {
        guard point.x >= 0 || point.y >= 0 else { return false }
        self.point = point
        return true
    }
}

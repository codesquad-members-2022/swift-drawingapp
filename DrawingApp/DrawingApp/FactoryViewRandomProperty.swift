//
//  FactoryViewRandomProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation
import UIKit

class FactoryViewRandomProperty: ViewPropertyCreator {
    
    private let name: String
    private let superview: UIView
    
    private var viewFrame: CGRect {
        superview.frame
    }
    
    init(name: String, superview: UIView) {
        
        self.name = name
        self.superview = superview
        
        super.init()
    }
    
    func make() -> ViewRandomProperty {
        
//        let locationProperty = getRandomPoint()
        let locationProperty = getRandomSizeAndPoint()
        
        return ViewRandomProperty(
            as: name,
            using: String.randomViewIdGenerator,
            at: locationProperty.point,
            size: locationProperty.size,
            color: rectRGBPointGenerator(maxR: 255, maxG: 255, maxB: 255),
            alpha: Double.random(in: 0.0...1.0)
        )
    }
    
    private func getRandomSizeAndPoint() -> (size:RectSize, point:RectPoint) {
        let randomSize = rectSizeGenerator(maxWidth: viewFrame.width, maxHeight: viewFrame.height-130)
        let randomPoint = rectPointGenerator(
            maxPointX: viewFrame.maxX - randomSize.width,
            maxPointY: viewFrame.maxY - (randomSize.height + 130)
        )
        
        return (randomSize, randomPoint)
    }
    
    private func getRandomPoint() -> (size:RectSize, point:RectPoint) {
        let size = (width: 150, height: 120) as RectSize
        let randomPoint = rectPointGenerator(
            maxPointX: viewFrame.maxX - Double(150),
            maxPointY: (viewFrame.maxY - Double(130 * 2))
        )
        
        return (size, randomPoint)
    }
    
    func isExceededSuperView() -> Bool {
        let locationProperty = getRandomPoint()
        return (locationProperty.size.width + locationProperty.point.x) <= viewFrame.width && (locationProperty.size.height + locationProperty.point.y) <= viewFrame.height
    }
}

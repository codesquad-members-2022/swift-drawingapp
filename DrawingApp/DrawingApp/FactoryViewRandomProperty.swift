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
        
        var randomSize = rectSizeGenerator(maxWidth: viewFrame.width, maxHeight: viewFrame.height)
        var randomPoint = rectPointGenerator(maxPointX: viewFrame.maxX, maxPointY: viewFrame.maxY - Double(130))
        
        while (randomSize.height+randomPoint.y) >= (superview.frame.height)
                && (randomSize.width+randomPoint.x) >= (superview.frame.width)
        {
            randomSize = rectSizeGenerator(maxWidth: viewFrame.width, maxHeight: viewFrame.height)
            randomPoint = rectPointGenerator(maxPointX: viewFrame.maxX, maxPointY: viewFrame.maxY - Double(130))
        }
        
        return ViewRandomProperty(
            as: name,
            using: String.randomViewIdGenerator,
            at: randomPoint,
            size: randomSize,
            color: rectRGBPointGenerator(maxR: 255, maxG: 255, maxB: 255),
            alpha: Double.random(in: 0.0...1.0)
        )
    }
}

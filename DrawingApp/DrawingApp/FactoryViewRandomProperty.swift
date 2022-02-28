//
//  FactoryViewRandomProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import Foundation
import UIKit

class FactoryViewRandomProperty {
    static func make(as name: String, in superview: UIView) -> ViewRandomProperty {
        
        var randomSize = rectSizeGenerator(in: superview)
        var randomPoint = rectPointGenerator(in: superview)
        let bottomCap: Double = 130
        
        while (randomSize.width+randomPoint.y) >= (superview.frame.width-bottomCap)
                && (randomSize.height+randomPoint.x) >= (superview.frame.height)
        {
            randomSize = rectSizeGenerator(in: superview)
            randomPoint = rectPointGenerator(in: superview)
        }
        
        return ViewRandomProperty(
            as: name,
            using: String.randomViewIdGenerator,
            at: randomPoint,
            size: randomSize,
            color: rectRGBPointGenerator(in: superview),
            alpha: Double.random(in: 0.0...1.0)
        )
    }
    
    private static func rectPointGenerator(in view: UIView) -> RectPoint {
        (
            x: randomDouble(from: 0, to: view.frame.size.height),
            y: randomDouble(from: 0, to: view.frame.size.width)
        )
    }
    
    private static func rectSizeGenerator(in view: UIView) -> RectSize {
        (
            width: randomDouble(from: 0, to: view.frame.size.width),
            height: randomDouble(from: 0, to: view.frame.size.height)
        )
    }
    
    private static func rectRGBPointGenerator(in view: UIView) -> RectRGBColor {
        (
            r: randomDouble(from: 0, to: 255),
            g: randomDouble(from: 0, to: 255),
            b: randomDouble(from: 0, to: 255)
        )
    }
    
    private static func randomDouble(from: Double, to: Double) -> Double {
        guard from <= to else { return 0.0 }
        return Double.random(in: from...to)
    }
}

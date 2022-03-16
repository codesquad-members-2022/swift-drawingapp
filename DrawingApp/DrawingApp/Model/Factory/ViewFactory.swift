//
//  ViewFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import UIKit

class ViewFactory {
    
    static func createView(frame: CGRect, backgroundColor: UIColor?, alpha: CGFloat?) -> BasicShapeView {
        if let backgroundColor = backgroundColor, let alpha = alpha {
            return createRectangleView(frame: frame, backgroundColor: backgroundColor, alpha: alpha)
        }
        else {
            return createBasicShapeView(frame: frame)
        }
    }
    
    private static func createBasicShapeView(frame: CGRect) -> BasicShapeView {
        let view = BasicShapeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = frame
        return view
    }
    
    private static func createRectangleView(frame: CGRect, backgroundColor: UIColor, alpha: CGFloat) -> RectangleView {
        let view = RectangleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = frame
        view.backgroundColor = backgroundColor
        view.alpha = alpha
        return view
    }
}

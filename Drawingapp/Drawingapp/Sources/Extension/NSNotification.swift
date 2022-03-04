//
//  NotificationCenter.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/04.
//

import Foundation

extension NSNotification.Name {
    static let didDisSelectedRectangle = NSNotification.Name("didDisSelectedRectangle")
    static let didSelectedRectangle = NSNotification.Name("didSelectedRectangle")
    static let drawRectangle = NSNotification.Name("drawRectangle")
    static let updateColor = NSNotification.Name("updateColor")
    static let updatePoint = NSNotification.Name("updatePoint")
    static let updateSize = NSNotification.Name("updateSize")
    static let updateAlpha = NSNotification.Name("updateAlpha")
}

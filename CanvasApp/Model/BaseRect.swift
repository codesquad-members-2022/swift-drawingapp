//
//  BaseRect.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/18.
//

import Foundation
import CoreGraphics

protocol RectColorful {
    var color : CGColor { get }
    func changeColor(with: CGColor)
}

protocol RectAlphaful {
    var alpha : RectAlpha { get }
    func changeAlpha(to: RectAlpha)
}

protocol PictureAccessable {
    var media : URL { get }
}

protocol PointAccessable {
    var points : [CGPoint] { get }
}

protocol ObjectDescription {
    var id : UUID { get }
    var text : String { get }
    var imageName : String { get }
}

class BaseRect {
    private(set) var id     : UUID
    private(set) var origin : CGPoint
    private(set) var size   : CGSize
    private(set) var sequence : Int
    
    init(origin: CGPoint = CGPoint.zero, size: CGSize = CGSize.zero, sequence: Int = 1) {
        self.id = UUID()
        self.origin = origin
        self.size = size
        self.sequence = sequence
    }
}

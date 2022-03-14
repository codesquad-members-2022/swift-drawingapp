//
//  Image.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/14.
//

import Foundation

//TODO: Something deal with ImageRectangle
class Image {
    
    private var rectangles:[Point:ImageRectangle] = [:]
    private var selectedRectangle:ImageRectangle?
    
    var count:Int {
        self.rectangles.count
    }
}

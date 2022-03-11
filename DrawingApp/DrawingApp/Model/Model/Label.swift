//
//  Label.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/11.
//

import Foundation

class Label: ViewModel {
    private var text: String
    private var fontSize: Float
    private var fontColor: Color
    
    init(id: ID, origin: Point, size: Size, text: String, fontSize: Float, fontColor: Color) {
        self.text = text
        self.fontSize = fontSize
        self.fontColor = fontColor
        super.init(id: id, origin: origin, size: size)
    }
    
    static func random() -> Label {
        let labelID = ID.random()
        let origin = Point.random()
        let size = Size.standard()
        let string = dummyString.components(separatedBy: " ").randomElement() ?? " "
        let fontSize = Float.random(in: 16...32)
        let fontColor = Color.random()
        
        return Label(id: labelID, origin: origin, size: size, text: string, fontSize: fontSize, fontColor: fontColor)
    }
    
    static let dummyString = "Slip inside the eye of your mind Don't you know you might find A better place to play You said that you'd never been But all the things that you've seen Slowly fade away And so Sally can wait She knows it's too late As we're walking on by Her soul slides away But don't look back in anger I heard you say"
}

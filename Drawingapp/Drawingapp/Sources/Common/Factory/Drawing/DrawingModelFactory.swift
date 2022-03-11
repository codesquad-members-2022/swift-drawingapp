//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

class DrawingModelFactory {
    private let colorFactory: ColorFactory
    
    init(colorFactory: ColorFactory) {
        self.colorFactory = colorFactory
    }
    
    func makeRectangleModel(origin: Point) -> RectangleModel {
        let id = makeId()
        let size = Size(width: 150, height: 120)
        let color = colorFactory.makeRandomColor()
        let alpha = Alpha.allCases.randomElement() ?? .transpar10
        return RectangleModel(id: id, origin: origin, size: size, color: color, alpha: alpha)
    }
    
    func makePhotoModel(origin: Point, url: URL) -> PhotoModel {
        let id = makeId()
        let size = Size(width: 150, height: 120)
        let alpha = Alpha.transpar10
        return PhotoModel(id: id, origin: origin, size: size, alpha: alpha, url: url)
    }
    
    func makeLabelModel(origin: Point) -> LabelModel {
        let id = makeId()
        let font = Font(name: "AppleSDGothicNeo-Regular", size: 16)
        let fontColor = colorFactory.makeRandomColor()
        let alpha = Alpha.allCases.randomElement() ?? .transpar10
        
        let uiFont = UIFont(name: font.name, size: font.size)
        let text = makeRandomText()
        let labelSize = NSString(string: text).size(withAttributes: [.font:uiFont])
        let size = Size(width: labelSize.width + 10, height: labelSize.height + 10)
        
        return LabelModel(id: id, origin: origin, size: size, alpha: alpha, text: text, font: font, fontColor: fontColor)
    }
    
    func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
    
    func makeRandomText() -> String {
        let randomWords =
"""
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas tellus rutrum tellus pellentesque eu. Viverra justo nec ultrices dui sapien eget mi proin sed. Vel pretium lectus quam id leo. Molestie at elementum eu facilisis sed odio morbi quis commodo. Risus at ultrices mi tempus imperdiet nulla malesuada. In est ante in nibh mauris cursus mattis molestie a. Venenatis urna cursus eget nunc. Eget velit aliquet sagittis id consectetur purus ut. Amet consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Consequat nisl vel pretium lectus quam id. Nisl vel pretium lectus quam id leo in vitae turpis. Purus faucibus ornare suspendisse sed. Amet mauris commodo quis imperdiet.
""".split(separator: " ")
        let randomIndex = Int.random(in: 0..<randomWords.count - 4)
        let randomText = (randomIndex..<randomIndex+5).reduce(""){
            $0 + " " + randomWords[$1]
        }.dropFirst()
        return String(randomText)
    }
}

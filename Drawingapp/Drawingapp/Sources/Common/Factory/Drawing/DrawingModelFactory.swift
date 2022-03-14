//
//  Factory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

class DrawingModelFactory: PlaneModelFactoryBase {
    func make(modelType: DrawingModel.Type, _ data: [Any] = []) -> DrawingModel {
        let id = makeId()
        let size = Size(width: 150, height: 120)
        let alpha = Alpha.allCases.randomElement() ?? .transpar10
        let origin = Point(x: Int.random(in: 0..<500), y: Int.random(in: 0..<500))
        
        switch modelType{
        case is RectangleModel.Type:
            let color = Color(using: RandomColorGenerator())
            return RectangleModel(id: id, index: 0, origin: origin, size: size, color: color, alpha: alpha)
        case is PhotoModel.Type:
            return PhotoModel(id: id, index: 0 ,origin: origin, size: size, alpha: alpha, url: data[0] as? URL)
        case is LabelModel.Type:
            let font = Font(name: "AppleSDGothicNeo-Regular", size: 16)
            let fontColor = Color(using: RandomColorGenerator())
            let text = makeRandomText()
            return LabelModel(id: id, index: 0, origin: origin, size: size, alpha: alpha, text: text, font: font, fontColor: fontColor)
        default:
            return DrawingModel(id: id, index: 0, origin: origin, size: size, alpha: alpha)
        }
    }
        
    private func makeId() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<3).reduce(""){ id, _ in
            let randomId = String((0..<3).compactMap{ _ in chars.randomElement()})
            return id + randomId + "-"
        }.dropLast())
    }
    
    private func makeRandomText() -> String {
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

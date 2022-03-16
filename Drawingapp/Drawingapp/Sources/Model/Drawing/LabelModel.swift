//
//  LabelModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation
import UIKit

protocol Textable: Drawingable {
    var font: Font { get }
    var text: String { get }
    func update(fontName: String)
}

class LabelModel: DrawingModel, Textable, Viewable {
    public private(set) var font: Font
    public private(set) var text: String
    
    override var description: String {
        "id: ( \(id) ), \(origin), \(size), alpha: \(alpha), text: \(text)"
    }
    
    var displayName: String {
        "Text \(index)"
    }
    
    var iconName: String {
        "ic_text"
    }
    
    init(id: String, index: Int, origin: Point, size: Size, alpha: Alpha, text: String, font: Font, fontColor: Color) {
        self.text = text
        self.font = font
        super.init(id: id, index: index, origin: origin, size: size, alpha: alpha)
    }
    
    func update(fontName: String) {
        self.font = Font(name: fontName, size: self.font.size)
    }
}

extension LabelModel: DrawingModelFactoryable {
    static func make(id: String, origin: Point, size: Size, alpha: Alpha, data: [Any]) -> DrawingModel {
        let text = makeRandomText()
        let font = Font(name: "AppleSDGothicNeo-Regular", size: 15)
        let fontColor = Color(using: RandomColorGenerator())
        let labelSize = NSString(string: text).size(withAttributes: [.font:font.uiFont])
        let modelSize = Size(width: labelSize.width + 10, height: labelSize.height + 10)
        return LabelModel(id: id, index: 0, origin: origin, size: modelSize, alpha: alpha, text: text, font: font, fontColor: fontColor)
    }
    
    private static func makeRandomText() -> String {
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


//
//  LayerFactory.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/14.
//

import Foundation

enum LayerFactory {
    static func makeRandom<T: Layer>(_ type: T.Type, titleOrder: Int, from data: Data? = nil) -> Layer? {
        let ID = ID.random()
        let origin = Point.random()
        let size = Size.standard()
        let alpha = Alpha(Alpha.max)!
        
        switch type {
        case is Rectangle.Type:
            let color = Color.random()
            return Rectangle(title: "Rect \(titleOrder)", id: ID, origin: origin, size: size, color: color, alpha: alpha)
        case is Photo.Type:
            guard let data = data else { return nil }
            return Photo(title: "\(Photo.self) \(titleOrder)", id: ID, origin: origin, size: size, photo: data, alpha: alpha)
        case is Label.Type:
            let text = dummyString()
            let fontSize = Float.random(in: 16...32)
            return Label(title: "\(Label.self) \(titleOrder)", id: ID, origin: origin, size: size, text: text, fontSize: fontSize)
        case is PostIt.Type:
            let text = defaultString
            let color = Color.random()
            return PostIt(title: "\(PostIt.self) \(titleOrder)", id: ID, origin: origin, size: size, text: text, color: color)
        default:
            return nil
        }
    }
    
    private static let defaultString = "Text"
    
    private static let dummyString: () -> String = {
        let lorem = "Slip inside the eye of your mind Don't you know you might find A better place to play You said that you'd never been But all the things that you've seen Slowly fade away And so Sally can wait She knows it's too late As we're walking on by Her soul slides away But don't look back in anger I heard you say"
        let dummyArray = lorem.components(separatedBy: " ")
        let randomIndex = Int.random(in: 0..<dummyArray.count-5)
        return dummyArray[randomIndex..<randomIndex+5].joined(separator: " ")
    }
}


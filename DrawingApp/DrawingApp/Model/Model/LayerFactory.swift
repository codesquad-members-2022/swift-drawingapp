//
//  LayerFactory.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/14.
//

import Foundation

enum LayerType {
    case rectangle
    case photo
    case label
}

enum LayerFactory {
    static func makeRandom(_ layerType: LayerType, from data: Data? = nil) -> Layer? {
        // Common property to initialize Layer
        let ID = ID.random()
        let origin = Point.random()
        let size = Size.standard()
        let alpha = Alpha.random()
        
        switch layerType {
        case .rectangle:
            let color = Color.random()
            return Rectangle(id: ID, origin: origin, size: size, color: color, alpha: alpha)
        case .photo:
            guard let data = data else { return nil }
            return Photo(id: ID, origin: origin, size: size, photo: data, alpha: alpha)
        case .label:
            let text = dummyString()
            let fontSize = Float.random(in: 16...32)
            return Label(id: ID, origin: origin, size: size, text: text, fontSize: fontSize)
        }
    }
    
    private static let dummyString: () -> String = {
        let lorem = "Slip inside the eye of your mind Don't you know you might find A better place to play You said that you'd never been But all the things that you've seen Slowly fade away And so Sally can wait She knows it's too late As we're walking on by Her soul slides away But don't look back in anger I heard you say"
        let dummyArray = lorem.components(separatedBy: " ")
        let randomIndex = Int.random(in: 0..<dummyArray.count-5)
        return dummyArray[randomIndex..<randomIndex+5].joined(separator: " ")
    }
}

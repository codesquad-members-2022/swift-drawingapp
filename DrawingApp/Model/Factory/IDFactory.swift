//
//  RectangleIDFactory.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import Foundation

final class IDFactory{
    static func makeID() -> String{
        var makingId = ""
        var uuid = UUID().description
        
        while uuid.contains("-"){
            guard let index = uuid.firstIndex(of: "-") else{
                break
            }
            uuid.remove(at: index)
        }
        
        while makingId.count < 11{
            if makingId.count == 3 || makingId.count == 7{
                makingId.append("-")
            } else{
                makingId.append(uuid.randomElement() ?? "#")
            }
        }
        return makingId
    }
}

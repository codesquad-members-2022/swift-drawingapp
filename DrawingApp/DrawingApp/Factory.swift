//
//  Factory.swift
//  DrawingApp
//
//  Created by YEONGJIN JANG on 2022/02/28.
//

import Foundation

class Factory {
    struct RectangleView: CustomStringConvertible {
        enum Alpha: Int {
            case one = 1, two, three, four, five, six, seve, eight, nine, ten
            func selectRandomAlpha() -> Self {
                let randomNumber = Int.random(in: 1...10)
                if randomNumber =
            }
        }
        struct BackgroundColor {
            let R: UInt8
            let G: UInt8
            let B: UInt8
        }
        struct Size {
            let width: Double = 150.0
            let height: Double = 120.0
        }
        struct Point {
            let x: Double
            let y: Double
        }
        
        var  id: String {
            var uuid = UUID().uuidString.split(separator: "-").map{String($0)}
            uuid.removeFirst()
            uuid.removeLast()
            var resultArray: [String] = []
            for cell in uuid {
                var temp = cell
                temp.removeLast()
                resultArray.append(temp)
            }
            return resultArray.joined(separator: "-")
        }
        let size = Size()
        var point: Point {
            
        }
        let color: BackgroundColor
        let alpha: Alpha
        
        var description: String {
        }
    }
    
    static func createRandomRectangle() -> RectangleView {
        return RectangleView(point: <#T##RectangleView.Point#>, color: <#T##RectangleView.BackgroundColor#>, alpha: <#T##RectangleView.Alpha#>)
    }
}

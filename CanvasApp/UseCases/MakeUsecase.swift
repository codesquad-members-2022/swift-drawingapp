//
//  Usecase.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/17.
//

import Foundation
import CoreGraphics

fileprivate extension CGPoint {
    static func random(maxX: Int, maxY: Int) -> CGPoint {
        return CGPoint(x: Int.random(in: 1...maxX),
                       y: Int.random(in: 1...maxY))
    }
}

extension CGColor {
    static func random() -> CGColor {
        return CGColor(red: Double.random(in: 10...240)/255.0,
                       green: Double.random(in: 10...240)/255.0,
                       blue: Double.random(in: 10...240)/255.0, alpha: 1)
    }
}

struct MakeUsecase {
    private var plane : MakerablePlane
    
    init(makerable: MakerablePlane) {
        self.plane = makerable
    }
    
    func addRect() {
        let rect = FigureFactory.makeRect(origin: CGPoint.random(maxX: 930, maxY: 700), size: CGSize(width: 200, height: 150), color: CGColor.random())
        plane.addRect(rect)        
    }
    
    func addPicture(with url: URL) {
        let picture = FigureFactory.makePicture(origin: CGPoint.random(maxX: 930, maxY: 700), size: CGSize(width: 200, height: 150), media: url)
        plane.addPicture(picture)
    }
    
    func addDrawing(with points: [CGPoint]) {
        var leftTop = CGPoint(x: Int.max, y: Int.max)
        var rightBottom = CGPoint.zero
        for point in points {
            if point.x < leftTop.x {
                leftTop.x = point.x
            }
            if point.y < leftTop.y {
                leftTop.y = point.y
            }
            if point.x > rightBottom.x {
                rightBottom.x = point.x
            }
            if point.y > rightBottom.y {
                rightBottom.y = point.y
            }
        }
        let converted = points.map { CGPoint(x: $0.x - leftTop.x, y: $0.y - leftTop.y)  }
        let draw = FigureFactory.makeDrawing(origin: leftTop,
                                             size: CGSize(width: rightBottom.x - leftTop.x,
                                                             height: rightBottom.y - leftTop.y),
                                             with: converted,
                                             color: CGColor.random())
        plane.addDrawing(draw)
    }
}

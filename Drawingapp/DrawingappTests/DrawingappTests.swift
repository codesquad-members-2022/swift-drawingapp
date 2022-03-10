//
//  DrawingappTests.swift
//  DrawingappTests
//
//  Created by seongha shin on 2022/02/28.
//

import XCTest
@testable import Drawingapp


class DrawingappTests: XCTestCase, PlaneDelegate {

    let plane = Plane()
    var drawingModel: DrawingModel?
    
    override func setUp() {
        self.plane.delegate = self
    }
    
    func getDrawingModelFactory() -> DrawingModelFactory {
        DrawingModelFactory(sizeFactory: SizeFactory(), pointFactory: PointFactory(), colorFactory: ColorFactory())
    }
    
    class RandomColorGenerator: ColorValueGenerator {
        
        var r: UInt8 = 0
        var g: UInt8 = 0
        var b: UInt8 = 0
        
        var colorR: UInt8 {
            self.r = UInt8.random(in: 0...255)
            return self.r
        }
        
        var colorG: UInt8 {
            self.g = UInt8.random(in: 0...255)
            return self.g
        }
        
        var colorB: UInt8 {
            self.b = UInt8.random(in: 0...255)
            return self.b
        }
    }
    
    func testColor() {
        let randomValue = RandomColorGenerator()
        Color(using: RandomColorGenerator())
    }

    func testSelectTest() {
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didMakeDrawingModel, object: nil, queue: nil) { notification in

            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                return
            }
            self.drawingModel = model
        }

        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didSelectedDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                XCTFail("사각형이 선택되지 않았습니다")
                return
            }
            XCTAssertTrue(true)
        }

        plane.makeRectangleModel()

        guard let model = self.drawingModel else {
            XCTFail("사각형이 생성되지 않았습니다")
            return
        }

        self.plane.touchPoint(Point(x: model.point.x, y: model.point.y))
    }
    
    //사각형 뷰 생성 테스트
    func testMakeRectangleModel() {
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didMakeDrawingModel, object: nil, queue: nil) { notification in
            
            let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel
            XCTAssertTrue(model != nil, "사각형이 생성되지 않았습니다")
        }
        plane.makeRectangleModel()
    }
}

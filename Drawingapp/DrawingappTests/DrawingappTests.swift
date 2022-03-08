//
//  DrawingappTests.swift
//  DrawingappTests
//
//  Created by seongha shin on 2022/02/28.
//

import XCTest
@testable import Drawingapp

class DrawingappTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let plane = Plane(drawingModelFactory: DrawingModelFactory(sizeFactory: SizeFactory(), pointFactory: PointFactory(), colorFactory: ColorFactory()))
    var drawingModel: DrawingModel?
    
    class RandomColorGenerator: ColorValueGenerator {
        var colorR: UInt {
            UInt.random(in: 0...255)
        }
        
        var colorG: UInt {
            UInt.random(in: 0...255)
        }
        
        var colorB: UInt {
            UInt.random(in: 0...255)
        }
    }
    
    func testColor() {
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
        
        self.plane.touchPoint(where: Point(x: model.point.x, y: model.point.y))
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

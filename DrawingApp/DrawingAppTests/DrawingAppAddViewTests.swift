//
//  DrawingAppAddViewTests.swift
//  DrawingAppAddViewTests
//
//  Created by 백상휘 on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class DrawingAppAddViewTests: XCTestCase {
    
    func testRectangleProperty() throws {
        
        let factory = FactoryRectangleProperty()
        let factoryProperties = RectangleRect.init(maxX: 300, maxY: 300, width: RectangleDefaultSize.width.rawValue, height: RectangleDefaultSize.height.rawValue)
        
        guard let testModel = factory.makeRandomRectangleModel(as: "TestView", rect: factoryProperties) else {
            XCTFail("[ERROR] Make testModel failed.")
            return
        }
        
        XCTAssertFalse(testModel.setPoint(RectOrigin(x: -1, y: -1)), "Model set point negative value not execute intentionally.")
        XCTAssertTrue(testModel.setPoint(RectOrigin(x: 1, y: 1)), "Model set point positive value not execute intentionally.")
        
        XCTAssertFalse(testModel.setSize(RectSize(width: -1, height: -1)), "Model set size negative value not execute intentionally.")
        XCTAssertTrue(testModel.setSize(RectSize(width: 1, height: 1)), "Model set size positive value not execute intentionally.")
        
        XCTAssertFalse(testModel.setAlpha(-1), "Model set alpha negative value not execute intentionally.")
        XCTAssertTrue(testModel.setAlpha(1), "Model set alpha positive value not execute intentionally.")
        
        for _ in 1...100 {
            guard let rgbValue = testModel.resetRGBColor() else {
                XCTFail("[ERROR] Reset rgb color failed.")
                return
            }
            
            for v in rgbValue.allValues {
                if v < 0 || v > RectRGBColor.maxValue {
                    XCTFail("[ERROR] RGBValue Number Excceded. \(rgbValue)")
                }
            }
        }
        
        LoggerUtil.debugLog(model: testModel)
    }
    
    
}

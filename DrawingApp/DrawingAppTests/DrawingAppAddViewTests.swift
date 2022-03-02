//
//  DrawingAppAddViewTests.swift
//  DrawingAppAddViewTests
//
//  Created by 백상휘 on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class DrawingAppAddViewTests: XCTestCase {

    func testDrawViewExceeded() throws {
        
        let factory = FactoryViewRandomProperty()
        factory.delegate = ViewController()
        
        for i in 1...100 {
            
            guard let model = factory.makeRandomView(as: "RandomView #\(i)") else {
                XCTFail()
                continue
            }
            
            print(model)
        }
    }
}

//
//  DrawingAppTests.swift
//  DrawingAppTests
//
//  Created by 백상휘 on 2022/02/28.
//

import XCTest
@testable import DrawingApp

class DrawingAppTests: XCTestCase {

    func testExample() throws {
        let randomProperty = FactoryViewRandomProperty.make(as: "random", in: ViewController().view)
        print(randomProperty)
    }
}

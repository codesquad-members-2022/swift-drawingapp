import XCTest
import OSLog

@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    var sut: Rectangle!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Factory.createRandomRectangle()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}

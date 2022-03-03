import XCTest
import OSLog

@testable import DrawingApp

class DrawingAppTests: XCTestCase {
    var sut: Factory!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Factory()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}

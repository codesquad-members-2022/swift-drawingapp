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
    
    class TestViewController: PlaneDelegate {
        var rectangle: Rectangle?
        func didMakeRectangle(rectangle: Rectangle) {
            self.rectangle = rectangle
        }
    }
    
    let testViewController = TestViewController()
    let model = Plane() // 쉬이이잉 3번
    
    func testMakeRectangle() {
        
        model.delegate = testViewController
        
        //1번,2번 : 이벤트가 발생 + 모델 만들어
        self.model.addRectangle()
        XCTAssertTrue(testViewController.rectangle != nil)
    }
}

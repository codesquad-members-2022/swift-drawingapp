import Foundation

class Plane {
    private var rectangleArray: [Rectangle] = []
    
    var rectangleCount: Int {
        return rectangleArray.count
    }
    
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangleArray.append(rectangle)
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangleArray[index]
    }
    
    func isTouched() -> Rectangle {
        return rectangleArray[0]
    }
}

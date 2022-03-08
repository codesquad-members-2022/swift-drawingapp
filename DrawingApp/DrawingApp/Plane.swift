import Foundation


class Plane {
    private var rectangleArray: [Rectangle] = []
    var rectangleCount: Int {
        return rectangleArray.count
    }
    var boundsOfRectangles: [Rectangle.Bound] {
        var bounds: [Rectangle.Bound] = []
        for rectangle in rectangleArray {
            bounds.append(rectangle.rangeOfPoint())
        }
        return bounds
    }
    
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangleArray.append(rectangle)
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangleArray[index]
    }
    
    func TouchedRectangle(at point: Rectangle.Point) -> Rectangle? {
        
        return rectangleArray[0]
    }
}

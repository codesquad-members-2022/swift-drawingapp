import Foundation

protocol RectangleAddedDelegate {
    func didMakeRectangle(rectangle: Rectangle)
}

protocol RectangleTouchedDelegate {
    func touchedRectangle(rectangle: Rectangle)
}

protocol PlaneColorChangeDelegate {
    func didChangeColor(rectangle: Rectangle)
}
protocol PlaneAlaphaChangeDelegate {
    func didChangeAlpha(_ rectangle: Rectangle)
}

class Plane {
    private var rectangleArray: [Rectangle] = []

    var addedRectangleDelegate :RectangleAddedDelegate?
    var touchedRectangleDelegate : RectangleTouchedDelegate?
    var colorDelegate: PlaneColorChangeDelegate?
    var alphaDelegate: PlaneAlaphaChangeDelegate?
    
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
        
        addedRectangleDelegate?.didMakeRectangle(rectangle: rectangle)
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangleArray[index]
    }
    
    func isTouchedOnRectangle(at point: Rectangle.Point) -> (bool: Bool, index: Int) {
        var index = 0
        for bound in boundsOfRectangles {
            if bound.rangeOfX.contains(point.x) && bound.rangeOfY.contains(point.y) {
                return (true, index)
            } else {
                index += 1
            }
        }
        //TODO: 안쓰는 값을 깔끔하게 정리
        return (false,99999)
    }
    
    func touchedRectangle(at point: Rectangle.Point) {
        let touchedResult = isTouchedOnRectangle(at: point)
        guard touchedResult.bool == true else {
            return
        }
        touchedRectangleDelegate?.touchedRectangle(rectangle: rectangleArray[touchedResult.index])
    }
    
    func changeColorOfRectangle(_ rectangle: Rectangle) {
        var oldRectangle = rectangle
        let newRectangle = oldRectangle.changeColor()
        self.colorDelegate?.didChangeColor(rectangle: newRectangle)
    }
    func changeAlpha(_ rectangle: Rectangle, _ alpha: Int) {
        var willChangeRectangle = rectangle
        willChangeRectangle = willChangeRectangle.changeAlpha(alpha)
        alphaDelegate?.didChangeAlpha(willChangeRectangle)
    }
}

import Foundation

class Plane {
    private(set) var rectangles: [Rectangle] = []
    
    var rectangleCount: Int {
        return rectangles.count
    }

    
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangles.append(rectangle)
        NotificationCenter.default.post(name: .add, object: self, userInfo: [NotificationKey.rectangle : rectangle])
    }
    
    subscript(index: Int) -> Rectangle {
        return rectangles[index]
    }
    
    private func isTouchedOnRectangle(at point: Point) -> Rectangle? {
        var optionalRectangle: Rectangle?
        for rectangle in rectangles {
            if rectangle.isIncluded(point: point) {
                optionalRectangle = rectangle
            }
        }
        return optionalRectangle
    }
    
    func touchedRectangle(at point: Point) {
        guard let rectangle = isTouchedOnRectangle(at: point) else {
            return
        }
        NotificationCenter.default.post(name: Notification.Name.select, object: self, userInfo: [NotificationKey.rectangle: rectangle])
    }
    
    func changeColorOfRectangle(_ rectangle: Rectangle) {
        var oldRectangle = rectangle
        let newRectangle = oldRectangle.changeColor()
        NotificationCenter.default.post(name: Notification.Name.change, object: self, userInfo: [NotificationKey.color: newRectangle])
    }
    
    func changeAlpha(_ rectangle: Rectangle, _ alpha: Int) {
        var willChangeRectangle = rectangle
        willChangeRectangle = willChangeRectangle.changeAlpha(alpha)
        NotificationCenter.default.post(name: Notification.Name.change, object: self, userInfo: [NotificationKey.alpha: willChangeRectangle])
    }
}

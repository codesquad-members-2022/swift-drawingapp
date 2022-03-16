import Foundation

class Plane {
    private var rectangles: [Rectangle] = []
    
    var rectangleCount: Int {
        return rectangles.count
    }

    
    func addRectangle() {
        let rectangle: Rectangle = Factory.createRandomRectangle()
        rectangles.append(rectangle)
        notificationCenter.post(name: .addRectangleView, object: nil, userInfo: [NotificationKey.addedRectangle : rectangle])
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
        notificationCenter.post(name: Notification.Name.tappedRectangleView, object: nil, userInfo: [NotificationKey.tappedRectangle: rectangle])
    }
    
    func changeColorOfRectangle(_ rectangle: Rectangle) {
        var oldRectangle = rectangle
        let newRectangle = oldRectangle.changeColor()
        notificationCenter.post(name: Notification.Name.colorChange, object: nil, userInfo: [NotificationKey.color: newRectangle])
    }
    
    func changeAlpha(_ rectangle: Rectangle, _ alpha: Int) {
        var willChangeRectangle = rectangle
        willChangeRectangle = willChangeRectangle.changeAlpha(alpha)
        notificationCenter.post(name: Notification.Name.alphaChange, object: nil, userInfo: [NotificationKey.alpha: willChangeRectangle])
    }
}

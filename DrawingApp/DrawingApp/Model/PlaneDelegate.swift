import Foundation

protocol PlaneDelegate: AnyObject{
    func addingRectangleCompleted(rectangle: Rectangle)
    func rectangleFoundFromPlane(rectangle: Rectangle)
    func rectangleNotFoundFromPlane()
}

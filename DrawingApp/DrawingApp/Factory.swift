import Foundation

class Factory {
    static func createRandomRectangle(name: String) -> RectangleView {
        return RectangleView(name: name)
    }
}

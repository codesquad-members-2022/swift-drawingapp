import Foundation

class Factory {
    static func createRandomRectangle(name: String) -> RectangleView {
        var  id: String {               // UUID: xxx-xxx-xxx
            var uuid = UUID().uuidString.split(separator: "-").map{String($0)}
            uuid.removeFirst()
            uuid.removeLast()
            var resultArray: [String] = []
            for cell in uuid {
                var temp = cell
                temp.removeLast()
                resultArray.append(temp)
            }
            return resultArray.joined(separator: "-")
        }
        let size = RectangleView.Size()
        let point : RectangleView.Point = .random()
        let color : RectangleView.BackgroundColor = .random()
        let alpha : RectangleView.Alpha = .random()
        return RectangleView(name: name, id: id, point: point, size: size, color: color, alpha: alpha)
    }
}

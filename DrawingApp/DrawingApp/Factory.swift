import Foundation


// 어느것을 class로 할지 struct로 할지 나름의 기준:  속성이 안바뀌는 객체들은 struct로 선언
// class는 내부속성이 바뀌거나, 자신만의 아이덴티티가 있어야하면 선언
struct Factory {
    static func createRandomRectangle() -> Rectangle {
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
        let size = Rectangle.Size()
        let point : Rectangle.Point = Rectangle.Point()
        let color : Rectangle.BackgroundColor = Rectangle.BackgroundColor()
        let alpha : Rectangle.Alpha = .random()
        return Rectangle(id: id, point: point, size: size, color: color, alpha: alpha)
    }
}

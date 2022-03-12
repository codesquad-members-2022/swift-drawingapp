import Foundation

class ImageRectangle: Rectangle{
     
    var backgroundImage: Data
    override var description: String{
        return "(\(id)), \(size), \(point), \(backgroundImage.hashValue), \(alpha)"
    }
     
    init(id: Id, size: Size, point: Point, backgroundImage: Data, alpha: Alpha){
        self.backgroundImage = backgroundImage
        super.init(id: id, size: size, point: point, alpha: alpha)
    }
     
}

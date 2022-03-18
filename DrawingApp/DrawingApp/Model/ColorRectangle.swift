import Foundation

class ColorRectangle: Rectangle, RandomColorApplicable{

    private (set) var backgroundColor: Color
    override var description: String{
        return "(\(id)), \(size), \(point), \(backgroundColor), \(alpha)"
    }
    
    init(id: Id, size: Size, point: Point, backgroundColor: Color, alpha: Alpha){
        self.backgroundColor = backgroundColor
        super.init(id: id, size: size, point: point, alpha: alpha)
    }

    func updateBackgroundColor(newColor: Color){
        self.backgroundColor = newColor
    }
    
}

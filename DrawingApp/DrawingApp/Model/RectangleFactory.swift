import Foundation

class RectangleFactory{
    
    func createRenctangle()-> Rectangle{
        let id = createRandomStringId()
        let point = createRandomPoint()
        let size = createRandomRectangleSize()
        let color = createRandomColor()
        let alpha = createRandomAlpha()
        
        return Rectangle(id: id, size: size, point: point, backgroundColor: color, alpha: alpha)
    }
    
    private func createRandomStringId()-> Rectangle.Id{
        return Rectangle.Id()
    }
    
    private func createRandomPoint()-> Rectangle.Point{
        return Rectangle.Point(x: Double.random(in: 1...100), y: Double.random(in: 1...100))
    }
    
    private func createRandomRectangleSize()-> Rectangle.Size{
        return Rectangle.Size(width: Double.random(in: 1...100), height: Double.random(in: 1...100))
    }
    
    private func createRandomColor()-> Rectangle.Color{
        return Rectangle.Color(r: Double.random(in: 0...255), g: Double.random(in: 0...255), b: Double.random(in: 0...255))
    }
    
    private func createRandomAlpha()-> Rectangle.Alpha{
        return Rectangle.Alpha.allCases[Int.random(in: 0...9)]
    }
}

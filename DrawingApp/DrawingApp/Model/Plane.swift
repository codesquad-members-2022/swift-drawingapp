import Foundation

struct Plane:CustomStringConvertible{
    
    private var rectangles:[String:Rectangle] = [:]
    private var rectangleIndex:[String] = []
    var count: Int{
        return rectangles.count
    }
    var description: String{
        return self.rectangles.description
    }
    
    mutating func addRectangle(_ rectangle: Rectangle){
        self.rectangles[rectangle.id.description] = rectangle
        self.rectangleIndex.append(rectangle.id.description)
    }
    
    private func isRectangleInsideTheRange(x: Double, y: Double, rectangle: Rectangle)-> Bool{
        
        let minX = rectangle.point.x
        let minY = rectangle.point.y
        let maxX = rectangle.point.x + rectangle.size.width
        let maxY = rectangle.point.y + rectangle.size.height
        if((x <= maxX && x >= minX) && (y <= maxY && y >= minY)){
            return true
        }
        
        return false
    }
    
    subscript(index: Int = 0)-> Rectangle?{
        if(index < 0 || index >= self.rectangleIndex.count){
            return nil
        }
        return self.rectangles[rectangleIndex[index]]
    }

    subscript(x: Double = 0, y: Double = 0)-> Rectangle?{
        for id in rectangles.keys{
            guard let rectangle = rectangles[id] else { continue }
            if(isRectangleInsideTheRange(x: x, y: y, rectangle: rectangle)){
                return rectangle
            }
        }
        return nil
    }
}

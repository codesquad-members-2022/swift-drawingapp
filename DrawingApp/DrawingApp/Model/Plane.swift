import Foundation

struct Plane:CustomStringConvertible{
    
    private var rectangles:[Rectangle.Id:Rectangle] = [:]
    private(set) var selectedRectangleId: Rectangle.Id?
    var count: Int{
        return rectangles.count
    }
    var description: String{
        return self.rectangles.description
    }
    weak var delegate: PlaneDelegate?
    
    mutating func findMatchingRectangleModel(x: Double, y: Double){
        if let delegate = self.delegate{
            guard let rectangle = self[x,y] else {
                delegate.rectangleNotFoundFromPlane()
                return
            }
            self.selectedRectangleId = rectangle.id
            delegate.rectangleFoundFromPlane(rectangle: rectangle)
        }
    }
    
    mutating func addRectangle(_ rectangle: Rectangle){
        self.rectangles[rectangle.id] = rectangle
        if let delegate = self.delegate{
            delegate.addingRectangleCompleted(rectangle: rectangle)
        }
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
    
    subscript(id: Rectangle.Id)-> Rectangle?{
        if let rectangle = rectangles[id]{
            return rectangle
        }
        return nil
    }
    
    subscript(x: Double = 0, y: Double = 0)-> Rectangle?{
  
        for id in self.rectangles.keys{
            guard let rectangle = rectangles[id] else { continue }
            if(isRectangleInsideTheRange(x: x, y: y, rectangle: rectangle)){
                return rectangle
            }
        }
        return nil
    }
}

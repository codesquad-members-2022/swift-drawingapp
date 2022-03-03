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
    
    subscript(index: Int = 0)-> Rectangle?{
        if(index <= 0 || index >= self.rectangleIndex.count){
            return nil
        }
        return self.rectangles[rectangleIndex[index]]
    }
}

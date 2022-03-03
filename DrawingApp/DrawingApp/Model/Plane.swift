import Foundation

struct Plane{
    
    private var rectangles:[Rectangle] = []
    var count: Int{
        return rectangles.count
    }
    
    mutating func addRectangle(rectangle: Rectangle){
        self.rectangles.append(rectangle)
    }
    
    subscript(index: Int = 0)-> Rectangle?{
        if(index <= 0 || index >= self.rectangles.count){
            return nil
        }
        return self.rectangles[index]
    }
}

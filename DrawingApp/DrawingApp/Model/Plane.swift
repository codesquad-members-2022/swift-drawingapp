import Foundation

struct Plane:CustomStringConvertible{
    
    private var rectangles:[Rectangle] = []
    private var selectedRectangleIndex: Int?
    var count: Int{
        return rectangles.count
    }
    var description: String{
        return self.rectangles.description
    }
    
    mutating func findMatchingRectangleModel(x: Double, y: Double){
        guard let rectangle = self[x,y] else {
            self.selectedRectangleIndex = nil
            NotificationCenter.default.post(name: .rectangleNotFoundFromPlane, object: nil)
            return
        }
        self.selectedRectangleIndex = self[rectangle.id]
        NotificationCenter.default.post(name: .rectangleFoundFromPlane, object: rectangle, userInfo: nil)
    }
    
    mutating func addRectangle(_ rectangle: Rectangle){
        self.rectangles.append(rectangle)
        NotificationCenter.default.post(name: .rectangleAdded, object: rectangle, userInfo: nil)
    }
    
    mutating func updateRectangleColor(newColor: Rectangle.Color){
        guard let selectedRectangleIndex = self.selectedRectangleIndex else { return }
        self.rectangles[selectedRectangleIndex].backgroundColor = newColor
        NotificationCenter.default.post(name: .rectangleColorUpdated, object: newColor)
    }
    
    mutating func updateRectangleAlpha(opacity: Int){
        var opacity = opacity
        guard let selectedRectangleIndex = self.selectedRectangleIndex else { return }
        if(opacity == 10){
            opacity = opacity - 1
        }
        self.rectangles[selectedRectangleIndex].alpha = Rectangle.Alpha.allCases[opacity]
        NotificationCenter.default.post(name: .rectangleAlphaUpdated, object: opacity)
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
    
    subscript(id: Rectangle.Id)-> Int?{
        for index in 0..<rectangles.count {
            if(rectangles[index].id == id){
                return index
            }
        }
        return nil
    }
    
    subscript(x: Double = 0, y: Double = 0)-> Rectangle?{
  
        for rectangle in self.rectangles.reversed(){
            if(isRectangleInsideTheRange(x: x, y: y, rectangle: rectangle)){
                return rectangle
            }
        }
        return nil
    }
}

import Foundation

struct Plane:CustomStringConvertible{
    
    private var notificationCenter = NotificationCenter.default
    private var rectangles:[Rectangle.Id:Rectangle] = [:]
    private(set) var selectedRectangleId: Rectangle.Id?
    var count: Int{
        return rectangles.count
    }
    var description: String{
        return self.rectangles.description
    }
    
    mutating func findMatchingRectangleModel(x: Double, y: Double){
        guard let rectangle = self[x,y] else {
            self.selectedRectangleId = nil
            self.notificationCenter.post(name: .rectangleNotFoundFromPlane, object: nil)
            return
        }
        self.selectedRectangleId = rectangle.id
        self.notificationCenter.post(name: .rectangleFoundFromPlane, object: rectangle, userInfo: nil)
    }
    
    mutating func addRectangle(_ rectangle: Rectangle){
        self.rectangles[rectangle.id] = rectangle
        self.notificationCenter.post(name: .rectangleAdded, object: rectangle, userInfo: nil)
    }
    
    mutating func updateRectangleColor(rgb: [Double]){
        guard let selectedRectangleId = self.selectedRectangleId else { return }
        guard let rectangle = self.rectangles[selectedRectangleId] else { return }
        rectangle.backgroundColor = Rectangle.Color(r: rgb[0]*255, g: rgb[1]*255, b: rgb[2]*255)
        self.notificationCenter.post(name: .rectangleColorUpdated, object: rgb)
    }
    
    mutating func updateRectangleAlpha(opacity: Int){
        var opacity = opacity
        guard let selectedRectangleId = self.selectedRectangleId else { return }
        guard let rectangle = self.rectangles[selectedRectangleId] else { return }
        if(opacity == 10){
            opacity = opacity - 1
        }
        rectangle.alpha = Rectangle.Alpha.allCases[opacity]
        self.notificationCenter.post(name: .rectangleAlphaUpdated, object: opacity)
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

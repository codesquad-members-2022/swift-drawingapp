import Foundation

extension Notification.Name{

    static let rectangleAdded = Notification.Name("rectangleAdded")
    static let rectangleFoundFromPlane = Notification.Name("rectangleFoundFromPlane")
    static let rectangleNotFoundFromPlane = Notification.Name("rectangleNotFoundFromPlane")
    static let rectangleColorUpdated = Notification.Name("rectangleColorUpdated")
    static let rectangleAlphaUpdated = Notification.Name("rectangleAlphaUpdated")
}

class Plane:CustomStringConvertible{
    
    enum UserInfoKey: String{
        case rectangleFound = "rectangleFound"
        case rectangleAdded = "rectangleAdded"
        case rectangleColorUpdated = "rectangleColorUpdated"
        case rectangleAlphaUpdated = "rectangleAlphaUpdated"
    }
    
    private var rectangles:[Rectangle] = []
    private var selectedRectangleIndex: Int?
    var count: Int{
        return rectangles.count
    }
    var description: String{
        return self.rectangles.description
    }
    
    func findMatchingRectangleModel(x: Double, y: Double){
        guard let rectangle = self[x,y] else {
            self.selectedRectangleIndex = nil
            NotificationCenter.default.post(name: .rectangleNotFoundFromPlane, object: self, userInfo: nil)
            return
        }
        self.selectedRectangleIndex = self[rectangle.id]
        NotificationCenter.default.post(name: .rectangleFoundFromPlane, object: self, userInfo: [UserInfoKey.rectangleFound:rectangle])
    }
    
    func addRectangle(_ rectangle: Rectangle){
        self.rectangles.append(rectangle)
        NotificationCenter.default.post(name: .rectangleAdded, object: self, userInfo: [UserInfoKey.rectangleAdded: rectangle])
    }
    
    func updateRectangleColor(newColor: Rectangle.Color){
        guard let selectedRectangleIndex = self.selectedRectangleIndex else { return }
        self.rectangles[selectedRectangleIndex].backgroundColor = newColor
        NotificationCenter.default.post(name: .rectangleColorUpdated, object: self, userInfo: [UserInfoKey.rectangleColorUpdated:newColor])
    }
    
    func updateRectangleAlpha(opacity: Int){
        var opacity = opacity
        guard let selectedRectangleIndex = self.selectedRectangleIndex else { return }
        if(opacity == 10){
            opacity = opacity - 1
        }
        self.rectangles[selectedRectangleIndex].alpha = Rectangle.Alpha.allCases[opacity]
        NotificationCenter.default.post(name: .rectangleAlphaUpdated, object: self, userInfo: [UserInfoKey.rectangleAlphaUpdated:opacity])
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

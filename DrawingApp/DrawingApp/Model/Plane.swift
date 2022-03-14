import Foundation

class Plane:CustomStringConvertible{
    
    enum UserInfoKey: String{
        case rectangleFound = "rectangleFound"
        case selectedRectangleIndex = "selectedRectangleIndex"
        case rectangleAdded = "rectangleAdded"
        case rectangleColorUpdated = "rectangleColorUpdated"
        case rectangleAlphaUpdated = "rectangleAlphaUpdated"
    }
    
    struct NotificationName{
        static let rectangleAdded = Notification.Name("rectangleAdded")
        static let rectangleFoundFromPlane = Notification.Name("rectangleFoundFromPlane")
        static let rectangleNotFoundFromPlane = Notification.Name("rectangleNotFoundFromPlane")
        static let rectangleColorUpdated = Notification.Name("rectangleColorUpdated")
        static let rectangleAlphaUpdated = Notification.Name("rectangleAlphaUpdated")
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
            NotificationCenter.default.post(name: NotificationName.rectangleNotFoundFromPlane, object: self, userInfo: nil)
            return
        }
        NotificationCenter.default.post(name: NotificationName.rectangleFoundFromPlane, object: self, userInfo: [UserInfoKey.rectangleFound:rectangle])
    }
    
    func addRectangle(_ rectangle: Rectangle){
        self.rectangles.append(rectangle)
        NotificationCenter.default.post(name: NotificationName.rectangleAdded, object: self, userInfo: [UserInfoKey.rectangleAdded: rectangle])
    }
    
    func updateRectangleColor(newColor: ColorRectangle.Color){
        guard let selectedRectangleIndex = self.selectedRectangleIndex else { return }
        guard let selectedRectangle = self.rectangles[selectedRectangleIndex] as? ColorRectangle else { return }
        selectedRectangle.updateBackgroundColor(newColor: newColor)
        NotificationCenter.default.post(name: NotificationName.rectangleColorUpdated, object: self, userInfo: [UserInfoKey.rectangleColorUpdated:newColor])
    }
    
    func updateRectangleAlpha(opacity: Int){
        guard let selectedRectangleIndex = self.selectedRectangleIndex else { return }
        let selectedRectangle = self.rectangles[selectedRectangleIndex]
        selectedRectangle.alpha = Rectangle.Alpha(opacity: opacity)
        NotificationCenter.default.post(name: NotificationName.rectangleAlphaUpdated, object: self, userInfo: [UserInfoKey.rectangleAlphaUpdated:opacity])
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
    
    subscript(x: Double = 0, y: Double = 0)-> Rectangle?{
        
        for index in stride(from: self.rectangles.count-1, through: 0, by: -1){
            let rectangle = self.rectangles[index]
            if(isRectangleInsideTheRange(x: x, y: y, rectangle: rectangle)){
                self.selectedRectangleIndex = index
                return rectangle
            }

        }
        return nil
    }
}

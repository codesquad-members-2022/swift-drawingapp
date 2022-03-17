import Foundation

class RectangleFactory{
    
    static func createImageRectangle(maxX: Double, maxY: Double, minWidth: Double, minHeight: Double, maxWidth: Double, maxHeight: Double, image: Data)-> RectangleApplicable & CustomImageApplicable{
        let id = createRandomStringId()
        let point = createRandomPoint(maxX: maxX, maxY: maxY)
        let size = createRandomRectangleSize(minWidth: minWidth, minHeight: minHeight, maxWidth: maxWidth, maxHeight: maxHeight)
        let alpha = Alpha.init(opacity: 10)
        
        return ImageRectangle(id: id, size: size, point: point, backgroundImage: image, alpha: alpha)
    }
    
    static func createColorRenctangle(maxX: Double, maxY: Double, minWidth: Double, minHeight: Double, maxWidth: Double, maxHeight: Double)-> RectangleApplicable & RandomColorApplicable{
        let id = createRandomStringId()
        let point = createRandomPoint(maxX: maxX, maxY: maxY)
        let size = createRandomRectangleSize(minWidth: minWidth, minHeight: minHeight, maxWidth: maxWidth, maxHeight: maxHeight)
        let color = createRandomColor()
        let alpha = createRandomAlpha()
        
        return ColorRectangle(id: id, size: size, point: point, backgroundColor: color, alpha: alpha)
    }
    
    private static func createRandomStringId()->Id{
        return Id()
    }
    
    private static func createRandomPoint(maxX: Double, maxY: Double)-> Point{
        return Point(x: Double.random(in: 1...maxX), y: Double.random(in: 1...maxY))
    }
    
    private static func createRandomRectangleSize(minWidth: Double, minHeight: Double, maxWidth: Double, maxHeight: Double)-> Size{
        return Size(width: Double.random(in: minWidth...maxWidth), height: Double.random(in: minHeight...maxHeight))
    }
    
    static func createRandomColor()-> Color{
        return Color(r: Double.random(in: 0...255), g: Double.random(in: 0...255), b: Double.random(in: 0...255))
    }
    
    private static func createRandomAlpha()-> Alpha{
        return Alpha(opacity: Int.random(in: 0...9))
    }
}

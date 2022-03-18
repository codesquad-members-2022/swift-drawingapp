import Foundation

protocol RectangleApplicable: CustomStringConvertible{
    var id: Id {get}
    var size: Size {get}
    var point: Point {get}
    var alpha: Alpha {get}
    var description: String { get }
    
    func updateAlpha(opacity: Int)
    func updatePoint(x: Double, y: Double)
}

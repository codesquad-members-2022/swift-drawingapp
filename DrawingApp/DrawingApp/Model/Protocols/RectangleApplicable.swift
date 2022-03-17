import Foundation

protocol RectangleApplicable: CustomStringConvertible{
    var id: Id {get}
    var size: Size {get}
    var point: Point {get set}
    var alpha: Alpha {get set}
    var description: String { get }
}

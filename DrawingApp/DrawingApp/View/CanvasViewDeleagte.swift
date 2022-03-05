import Foundation

protocol CanvasViewDelegate: AnyObject{
    func creatingRectangleRequested()
    func changeRectangleModelAlpha(opacity: Int)
    func changeRectangleModelColor(rgb: [Double])
    func clearModelSelection()
}

import Foundation

protocol ModelMutable: AnyObject{
    
    func changeRectangleModelAlpha(opacity: Int)
    func changeRectangleModelColor(rgb: [Double])
    func clearModelSelection()
}

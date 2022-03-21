import Foundation
import UIKit

class StylerViewController: UIViewController{
    
    weak var delegate: StylerViewControllerDelegate?
    
    override func didMove(toParent parent: UIViewController?) {
        setStylerView()
    }
    
    private func setStylerView(){
        guard let parent = self.parent else { return }
        guard let canvasView = parent.view.subviews[0] as? CanvasView else { return }
        let frame = CGRect(x: canvasView.frame.width,
                           y: parent.view.frame.minY,
                           width: parent.view.frame.width - canvasView.frame.width,
                           height: parent.view.frame.height)
        let stylerView = StylerView(frame: frame, backgroundColor: .white)
        stylerView.delegate = self
        self.view = stylerView
    }
    
    func updateSelectedRectangleInfo(rectangle: RectangleApplicable){
        if rectangle is RandomColorApplicable{
            self.updateColorRectangleInfo(rectangle: rectangle)
        }else{
            self.updateImageRectangleInfo(rectangle: rectangle)
        }
    }
    
    func clearSelectedRectangleInfo(){
        guard let stylerView = self.view as? StylerView else { return }
        stylerView.clearSelectedRectangleInfo()
    }
    
    private func updateColorRectangleInfo(rectangle: RectangleApplicable){
        guard let stylerView = self.view as? StylerView else { return }
        guard let rectangle = rectangle as? RectangleApplicable & RandomColorApplicable else { return }
        let r = rectangle.backgroundColor.r
        let g = rectangle.backgroundColor.g
        let b = rectangle.backgroundColor.b
        let opacity = rectangle.alpha.opacity.rawValue
        let hexString = "#\(String(Int(r*255), radix: 16))\(String(Int(g*255), radix: 16))\(String(Int(b*255), radix: 16))"
        stylerView.updateColorRectangleInfo(r: r, g: g, b: b, opacity: opacity, hexString: hexString)
    }
    
    private func updateImageRectangleInfo(rectangle: RectangleApplicable){
        guard let stylerView = self.view as? StylerView else { return }
        stylerView.updateImageRectangleInfo(opacity: rectangle.alpha.opacity.rawValue)
    }
    
    func updateSelectedRectangleViewColorInfo(newColor: UIColor, newHexString: String){
        guard let stylerView = self.view as? StylerView else { return }
        stylerView.updateSelectedRectangleViewColorInfo(newColor: newColor, newHexString: newHexString)
    }
}

extension StylerViewController: StylerViewDelegate{
    
    func updatingSelectedRectangleColorRequested(){
        guard let delegate = self.delegate else { return }
        delegate.updatingSelectedRectangleColorRequested()
    }
    
    func updatingSelectedRectangleAlphaRequested(opacity: Int){
        guard let delegate = self.delegate else { return }
        delegate.updatingSelectedRectangleAlphaRequested(opacity: opacity)
    }
}

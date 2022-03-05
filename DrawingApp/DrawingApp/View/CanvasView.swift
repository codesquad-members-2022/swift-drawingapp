import Foundation
import UIKit

class CanvasView: UIView{
    
    weak var viewController: ModelMutable?
    private (set) var generatingButton: UIButton = UIButton()
    private (set) var selectedRectangleView: UIView?
    
    init(frame: CGRect, backGroundColor: UIColor, buttonActionClosure: @escaping ()->Void) {
        super.init(frame: frame)
        self.backgroundColor = backGroundColor
        setGeneratingButton()
        setGeneratingButtonAction(buttonActionClosure: buttonActionClosure)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func cancelSelection(){
        if let selectedRectangleView = self.selectedRectangleView,
           let viewController = self.viewController {
            selectedRectangleView.layer.borderWidth = 0
            self.selectedRectangleView = nil
            
            viewController.clearModelSelection()
        }
    }
    
    func selectTappedRectangle(subView: UIView){
        if let selectedRectangleView = self.selectedRectangleView {
            selectedRectangleView.layer.borderWidth = 0
        }
        subView.layer.borderWidth = 2
        self.selectedRectangleView = subView
    }
    
    func changeSelectedRectangleOpacity(opacity: Int){
        guard let viewController = self.viewController else { return }
        guard let selectedRectangleView = selectedRectangleView else { return }
        selectedRectangleView.alpha = CGFloat(opacity) / 10
        viewController.changeRectangleModelAlpha(opacity: opacity)
    }
    
    func changeSelectedRectangleColor(rgb: [Double]){
        guard let selectedRectangleView = selectedRectangleView else { return }
        selectedRectangleView.backgroundColor = UIColor(red: rgb[0], green: rgb[1], blue: rgb[2], alpha: 1)
    }
    
    private func setGeneratingButton(){
        let buttonWidth = self.frame.width*0.15
        let buttonHeight = self.frame.height*0.15
        self.generatingButton.frame = CGRect(x: 0, y: self.frame.height-buttonHeight, width: buttonWidth, height: buttonHeight*0.8)
        self.generatingButton.center.x = self.center.x
        
        self.generatingButton.backgroundColor = .white
        self.generatingButton.layer.cornerRadius = 10
        self.generatingButton.layer.borderWidth = 1
        
        self.generatingButton.setTitle("사각형🖌", for: .normal)
        self.generatingButton.setTitleColor(.black, for: .normal)
        self.generatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        self.addSubview(generatingButton)
    }
    
    private func setGeneratingButtonAction(buttonActionClosure: @escaping ()->Void){
        let buttonAction:UIAction = UIAction(title: ""){ _ in
            buttonActionClosure() }
        self.generatingButton.addAction(buttonAction, for: .touchDown)
    }
    
    subscript(x: Double, y: Double)-> UIView?{
        func isTappedPointInsideTheRange(view: UIView)-> Bool{
            if((x <= view.frame.maxX && x >= view.frame.minX) && (y <= view.frame.maxY && y >= view.frame.minY)){
                return true
            }
            return false
        }
        
        for view in self.subviews{
            if(isTappedPointInsideTheRange(view: view)){
                return view
            }
        }
        
        return nil
    }

}

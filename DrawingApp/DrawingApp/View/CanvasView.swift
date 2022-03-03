import Foundation
import UIKit

class CanvasView: UIView{
    
    private var generatingButton: UIButton = UIButton()
    
    init(frame: CGRect, backGroundColor: UIColor, buttonActionClosure: @escaping ()->Void) {
        super.init(frame: frame)
        self.backgroundColor = backGroundColor
        setGeneratingButton()
        setGeneratingButtonAction(buttonActionClosure: buttonActionClosure)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setGeneratingButton(){
        let buttonWidth = self.frame.width*0.15
        let buttonHeight = self.frame.height*0.15
        self.generatingButton.frame = CGRect(x: 0, y: self.frame.height-buttonHeight, width: buttonWidth, height: buttonHeight*0.8)
        self.generatingButton.center.x = self.center.x
        
        self.generatingButton.backgroundColor = .white
        self.generatingButton.layer.cornerRadius = 10
        self.generatingButton.layer.borderWidth = 2
        
        self.generatingButton.setTitle("사각형🖌", for: .normal)
        self.generatingButton.setTitleColor(.black, for: .normal)
        self.generatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        self.addSubview(generatingButton)
    }
    
    private func setGeneratingButtonAction(buttonActionClosure: @escaping ()->Void){
        let buttonAction:UIAction = UIAction(title: ""){ _ in
            buttonActionClosure() }
        self.generatingButton.addAction(buttonAction, for: .touchDown)
    }

}

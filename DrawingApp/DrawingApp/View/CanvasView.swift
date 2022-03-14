import Foundation
import UIKit

class CanvasView: UIView{
    
    weak var delegate: CanvasViewDelegate?
    private (set) var generatingButton: UIButton = UIButton()
    private (set) var photoButton: UIButton = UIButton()
    private (set) var selectedRectangleView: UIView?
    
    init(frame: CGRect, backGroundColor: UIColor) {
        super.init(frame: frame)
        self.backgroundColor = backGroundColor
        setGeneratingButton()
        setPhotoButton()
        setGeneratingButtonAction()
        setPhotoButtonAction()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func clearRectangleViewSelection(){
        if let selectedRectangleView = self.selectedRectangleView{
            selectedRectangleView.layer.borderWidth = 0
            self.selectedRectangleView = nil
        }
    }
    
    func updateSelectedRectangleView(subView: UIView){
        if let selectedRectangleView = self.selectedRectangleView{
            selectedRectangleView.layer.borderWidth = 0
        }
        subView.layer.borderWidth = 2
        self.selectedRectangleView = subView
    }
    
    func updateSelectedRectangleOpacity(opacity: Int){
        guard let selectedRectangleView = selectedRectangleView else { return }
        selectedRectangleView.alpha = CGFloat(opacity) / 10
    }
    
    func updateSelectedRectangleViewColor(newColor: UIColor){
        guard let selectedRectangleView = selectedRectangleView else { return }
        selectedRectangleView.backgroundColor = newColor
    }
    
    private func setGeneratingButton(){
        let buttonWidth = self.frame.width*0.15
        let buttonHeight = self.frame.height*0.15
        self.generatingButton.frame = CGRect(x: 0, y: self.frame.height-buttonHeight, width: buttonWidth, height: buttonHeight*0.8)
        self.generatingButton.center.x = self.center.x - 50
        
        self.generatingButton.backgroundColor = .white
        self.generatingButton.layer.cornerRadius = 10
        self.generatingButton.layer.borderWidth = 1
        
        self.generatingButton.setTitle("사각형🖌", for: .normal)
        self.generatingButton.setTitleColor(.black, for: .normal)
        self.generatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        self.addSubview(generatingButton)
    }
    
    private func setPhotoButton(){
        let buttonWidth = self.frame.width*0.15
        let buttonHeight = self.frame.height*0.15
        self.photoButton.frame = CGRect(x: self.generatingButton.frame.maxX + 50, y: self.frame.height-buttonHeight, width: buttonWidth, height: buttonHeight*0.8)
        
        self.photoButton.backgroundColor = .white
        self.photoButton.layer.cornerRadius = 10
        self.photoButton.layer.borderWidth = 1
        
        self.photoButton.setTitle("사진🖼", for: .normal)
        self.photoButton.setTitleColor(.black, for: .normal)
        self.photoButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        self.addSubview(photoButton)
    }
    
    private func setGeneratingButtonAction(){
        let buttonAction:UIAction = UIAction(title: ""){ _ in
            self.sendCreatingRectangleRequest()
        }
        self.generatingButton.addAction(buttonAction, for: .touchDown)
    }
    
    private func setPhotoButtonAction(){
        let buttonAction:UIAction = UIAction(title:""){_ in
            self.sendPickingImageRequest()
        }
        self.photoButton.addAction(buttonAction, for: .touchDown)
    }
    
    private func sendCreatingRectangleRequest(){
        delegate?.creatingRectangleRequested()
    }
    
    private func sendPickingImageRequest(){
        delegate?.pickingImageRequested()
    }

}

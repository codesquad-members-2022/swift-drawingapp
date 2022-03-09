//
//  ControlPanelView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

protocol ControlPanelViewDelegate {
    func controlPanelDidPressColorButton()
    func controlPanelDidPressAlphaStepper(_ sender: UIStepper)
}

class ControlPanelView: UIView {
    // MARK: - Properties
    var delegate: ControlPanelViewDelegate?
    
    let colorLabel = SimpleLabel(title: "배경색")
    let colorButton = RoundedButton(type: .system)
    let alphaLabel = SimpleLabel(title: "투명도")
    let alphaSlider = UISlider()
    let alphaStepper = UIStepper()
    
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    // MARK: - UI Configuration
    func configureUI() {
        self.addSubview(self.colorLabel)
        self.addSubview(self.alphaLabel)
        
        self.configureColorButton()
        self.configureAlphaSlider()
        self.configureAlphaStepper()
        self.configureViewElementsPosition()
    }
    
    func configureAlphaSlider() {
        self.alphaSlider.frame.size.width = 200
        self.alphaSlider.isEnabled = false
        self.alphaSlider.maximumValue = 10
        self.alphaSlider.minimumValue = 1
        self.alphaSlider.value = 5
        self.alphaSlider.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        
        self.addSubview(self.alphaSlider)
    }
    
    func configureAlphaStepper() {
        self.alphaStepper.maximumValue = 10
        self.alphaStepper.minimumValue = 1
        self.alphaStepper.value = 5
        self.alphaStepper.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        
        self.alphaStepper.addTarget(self, action: #selector(ControlPanelView.handleAlphaStepperPressed), for: .touchUpInside)
        
        self.addSubview(self.alphaStepper)
    }
    
    func configureColorButton() {
        let randomColor = UIColor.random()
        
        self.colorButton.setTitle(randomColor.toHexString(), for: .normal)
        self.colorButton.frame.size = CGSize(width: 200, height: 50)
        self.colorButton.addTarget(self, action: #selector(ControlPanelView.handleColorButtonPressed), for: .touchUpInside)
        
        self.addSubview(self.colorButton)
    }
    
    func configureViewElementsPosition() {
        let SPACE: CGFloat = 20
        
        self.colorLabel.frame.origin = CGPoint(x: 20, y: 90)
        self.colorButton.frame.origin = CGPoint(x: 20, y: colorLabel.frame.maxY + SPACE)
        self.alphaLabel.frame.origin = CGPoint(x: 20, y: colorButton.frame.maxY + SPACE)
        self.alphaSlider.frame.origin = CGPoint(x: 20, y: alphaLabel.frame.maxY + SPACE)
        self.alphaStepper.frame.origin = CGPoint(x: self.frame.width / 2 - self.alphaStepper.center.x, y: alphaSlider.frame.maxY + SPACE)
    }
    
    // MARK: - Action Methods
    @objc func handleColorButtonPressed(_ sender: RoundedButton) {
        self.delegate?.controlPanelDidPressColorButton()
    }
    
    @objc func handleAlphaStepperPressed(_ sender: UIStepper) {
        self.alphaSlider.value = Float(sender.value)
        self.delegate?.controlPanelDidPressAlphaStepper(sender)
    }
}

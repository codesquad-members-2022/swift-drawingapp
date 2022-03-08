//
//  ControlPanelView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

protocol ControlPanelViewDelegate {
    func controlPanelDidPressColorButton(sender: RoundedButton, color: UIColor)
    func controlPanelDidPressAlphaStepper(_ sender: AlphaStepper)
}

class ControlPanelView: UIView {
    // MARK: - Properties
    var delegate: ControlPanelViewDelegate?
    
    let colorLabel = AutoresizingLabel(title: "배경색")
    let alphaLabel = AutoresizingLabel(title: "투명도")
    let alphaSlider = AlphaSlider()
    let alphaStepper = AlphaStepper()
    let colorButton = RoundedButton(type: .system)
    
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    // MARK: - Configuration
    func configureUI() {
        let randomColor = UIColor.random()
        
        self.colorButton.setTitle(randomColor.toHexString(), for: .normal)
        self.colorButton.frame.size = CGSize(width: 200, height: 50)
        self.colorButton.addTarget(self, action: #selector(ControlPanelView.handleColorButtonPressed), for: .touchUpInside)
        self.alphaStepper.addTarget(self, action: #selector(ControlPanelView.handleAlphaStepperPressed), for: .touchUpInside)
        
        let SPACE: CGFloat = 20
        
        self.colorLabel.frame.origin = CGPoint(x: 20, y: 90)
        self.colorButton.frame.origin = CGPoint(x: 20, y: colorLabel.frame.maxY + SPACE)
        self.alphaLabel.frame.origin = CGPoint(x: 20, y: colorButton.frame.maxY + SPACE)
        self.alphaSlider.frame.origin = CGPoint(x: 20, y: alphaLabel.frame.maxY + SPACE)
        self.alphaStepper.frame.origin = CGPoint(x: self.frame.width / 2 - self.alphaStepper.center.x, y: alphaSlider.frame.maxY + SPACE)
        
        self.addSubview(self.colorLabel)
        self.addSubview(self.colorButton)
        self.addSubview(self.alphaLabel)
        self.addSubview(self.alphaSlider)
        self.addSubview(self.alphaStepper)
    }
    
    // MARK: - Action Methods
    @objc func handleColorButtonPressed(_ sender: RoundedButton) {
        let randomColor = UIColor.random()
        self.colorButton.setTitle(randomColor.toHexString(), for: .normal)
        
        self.delegate?.controlPanelDidPressColorButton(sender: sender, color: randomColor)
    }
    
    @objc func handleAlphaStepperPressed(_ sender: AlphaStepper) {
        self.alphaSlider.value = Float(sender.value)
        self.delegate?.controlPanelDidPressAlphaStepper(sender)
    }
}

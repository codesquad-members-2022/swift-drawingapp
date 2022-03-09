//
//  ControlPanelView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

protocol ControlPanelViewDelegate {
    func controlPanelDidPressColorButton()
    func controlPanelDidMoveAlphaSlider(_ sender: UISlider)
}

class ControlPanelView: UIView {
    // MARK: - Properties
    var delegate: ControlPanelViewDelegate?
    
    let colorLabel = SimpleLabel(title: "배경색")
    let colorButton = RoundedButton(type: .system)
    let alphaLabel = SimpleLabel(title: "투명도")
    let alphaSlider = UISlider()
    
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
        self.configureViewElementsPosition()
    }
    
    func configureAlphaSlider() {
        self.alphaSlider.frame.size.width = 200
        self.alphaSlider.maximumValue = 10
        self.alphaSlider.minimumValue = 1
        self.alphaSlider.value = 5
        self.alphaSlider.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        self.alphaSlider.addTarget(self, action: #selector(self.handleOnChangeAlpha), for: .valueChanged)
        
        self.addSubview(self.alphaSlider)
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
    }
    
    // MARK: - Action Methods
    @objc func handleColorButtonPressed(_ sender: RoundedButton) {
        self.delegate?.controlPanelDidPressColorButton()
    }
    
    @objc func handleOnChangeAlpha(_ sender: UISlider) {
        self.delegate?.controlPanelDidMoveAlphaSlider(sender)
    }
    
    // MARK: - Methods
    func setAlphaSliderValue(value: Alpha) {
        self.alphaSlider.value = Float(value.rawValue)
    }
    
    func setColorButtonTitle(title: String) {
        self.colorButton.setTitle(title, for: .normal)
    }
}

//
//  PanelView.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import Foundation
import UIKit

protocol PanelViewDelegate {
    func didTabRondomizeColor()
    func didTabChangeAlpha(sender : UIStepper)
}

class PanelView : UIView {
    
    private var colorRondomizeButton : UIButton!
    private var alphaStepper : UIStepper!
    
    private var alphaLabel : UILabel!
    private var colorTitleLabel : UILabel!
    private var transparencyLabel : UILabel!
    private let defaultAlphaValue = "0"
    private let defaultColorValue = "#000000"

    var delegate : PanelViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemGray3
        setupLables()
        setupButtons()
        setDefaultPanelValues()
        loadSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.systemGray3
        setupLables()
        setupButtons()
        setDefaultPanelValues()
        loadSubViews()
    }
    
    func updateAlpha(newAlphaValue : Double) {
        if let newValue = Alpha(rawValue: Int(newAlphaValue * 10.0)) {
            self.alphaLabel.text = "\(newValue.rawValue)" //Displays 1~10
            self.alphaStepper.value = newValue.value * 10.0 
        }
    }
    
    func updateRomdomizeColorButton(newColor : String) {
        self.colorRondomizeButton.setTitle(newColor, for: .normal)
    }
    
    func setDefaultPanelValues() {
        self.colorRondomizeButton.setTitle(defaultColorValue, for: .normal)
        self.alphaLabel.text = defaultAlphaValue
    }
    
    private func loadSubViews() {
        addSubview(colorTitleLabel)
        addSubview(transparencyLabel)
        addSubview(alphaLabel)
        addSubview(colorRondomizeButton)
        addSubview(alphaStepper)
    }
    
    private func setupLables() {
        
        self.colorTitleLabel = UILabel()
        self.transparencyLabel = UILabel()
        self.alphaLabel = UILabel()
        
        colorTitleLabel.textAlignment = .left
        transparencyLabel.textAlignment = .left
        alphaLabel.textAlignment = .center
        
        colorTitleLabel.text = "배경색"
        transparencyLabel.text = "투명도"
      
        
        colorTitleLabel.frame = CGRect(x: self.bounds.minX+20, y: self.bounds.minY+20, width: 160, height: 50)
        transparencyLabel.frame = CGRect(x: self.bounds.minX+20, y: self.bounds.minY+150, width: 160, height: 50)
        alphaLabel.frame = CGRect(x: self.bounds.minX, y: self.bounds.minY + 185.0, width: 160, height: 50)
    }
    
    private func setupButtons() {
        self.colorRondomizeButton = UIButton()
        self.alphaStepper = UIStepper()
        
        colorRondomizeButton.addTarget(target, action: #selector(didTabColorRondomizeButton), for: .touchUpInside)
        alphaStepper.addTarget(target, action: #selector(didTabAlphaStepper), for: .valueChanged)
        
        alphaStepper.minimumValue = 1
        alphaStepper.maximumValue = 10
        alphaStepper.wraps = false
        alphaStepper.stepValue = 1
        
        colorRondomizeButton.backgroundColor = .tintColor
        colorRondomizeButton.layer.cornerRadius = 10
        colorRondomizeButton.setTitle("", for: .normal)
       
        colorRondomizeButton.frame = CGRect(x: self.bounds.minX + 20, y: self.bounds.minY + 70.0, width: 160, height: 50)
        alphaStepper.frame = CGRect(x: self.bounds.minX + 100, y: self.bounds.minY + 190.0, width: 160, height: 50)
    }
    
    
    @objc func didTabColorRondomizeButton(sender: UIButton) {
        delegate?.didTabRondomizeColor()
        
    }
    @objc func didTabAlphaStepper(sender: UIStepper) {
        delegate?.didTabChangeAlpha(sender: sender)
    }
    
}

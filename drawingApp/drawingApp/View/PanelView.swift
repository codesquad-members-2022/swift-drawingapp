//
//  PanelView.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import Foundation
import UIKit
protocol PanelViewDelegate {
    func didRondomizeColor()
    func didChangeAlpha()
}

class PanelView : UIView {
    
    private var colorRondomizeButton : UIButton!
    private var alphaStepper : UIStepper!
    
    private var stepperLabel : UILabel!
    private var colorTitleLabel : UILabel!
    private var alphaTitleLabel : UILabel!
    
    var delegate : PanelViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemGray3
        setupLables()
        setupButtons()
        loadSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor.systemGray3
        setupLables()
        setupButtons()
        loadSubViews()
    }
    
  
    
    private func loadSubViews() {
        addSubview(colorTitleLabel)
        addSubview(alphaTitleLabel)
        addSubview(stepperLabel)
        addSubview(colorRondomizeButton)
        addSubview(alphaStepper)
    }
    
    private func setupLables() {
        
        self.colorTitleLabel = UILabel()
        self.alphaTitleLabel = UILabel()
        self.stepperLabel = UILabel()
        
        colorTitleLabel.textAlignment = .left
        alphaTitleLabel.textAlignment = .left
        stepperLabel.textAlignment = .center
        
        colorTitleLabel.text = "배경색"
        alphaTitleLabel.text = "투명도"
        stepperLabel.text = "0"
        
        colorTitleLabel.frame = CGRect(x: self.bounds.minX+20, y: self.bounds.minY+20, width: 160, height: 50)
        alphaTitleLabel.frame = CGRect(x: self.bounds.minX+20, y: self.bounds.minY+150, width: 160, height: 50)
        stepperLabel.frame = CGRect(x: self.bounds.minX, y: self.bounds.minY + 185.0, width: 160, height: 50)
    }
    
    private func setupButtons() {
        self.colorRondomizeButton = UIButton()
        self.alphaStepper = UIStepper()
        
        colorRondomizeButton.addTarget(colorRondomizeButton, action: #selector(didTabColorRondomizeButton), for: .touchUpInside)
        alphaStepper.addTarget(colorRondomizeButton, action: #selector(didTabAlphaStepper), for: .valueChanged)
        
        alphaStepper.minimumValue = 0
        alphaStepper.maximumValue = 10
        alphaStepper.wraps = false
        alphaStepper.stepValue = 1
        
        colorRondomizeButton.backgroundColor = .tintColor
        colorRondomizeButton.layer.cornerRadius = 10
        colorRondomizeButton.setTitle("", for: .normal)
       
       
        colorRondomizeButton.frame = CGRect(x: self.bounds.minX + 20, y: self.bounds.minY + 70.0, width: 160, height: 50)
        alphaStepper.frame = CGRect(x: self.bounds.minX + 100, y: self.bounds.minY + 190.0, width: 160, height: 50)
    }
    
    
    @objc func didTabColorRondomizeButton() {
        delegate?.didRondomizeColor()
    }
    @objc func didTabAlphaStepper() {
        delegate?.didChangeAlpha()
    }
    
}

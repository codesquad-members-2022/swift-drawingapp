//
//  RectangleViewBoard.swift
//  DrawingApp
//
//  Created by dale on 2022/03/07.
//

import UIKit

protocol PropertyChangeBoardDelegate {
    func propertyChangeBoard(didChanged alpha: Alpha)
    func propertyChangeBoardDidTouchedColorButton()
}

class PropertyChangeBoard : UIView {
    private let colorLabel = UILabel()
    private let colorChangeButton = UIButton()
    private let alphaLabel = UILabel()
    private let alphaChangeSlider = UISlider()
    var delegate : PropertyChangeBoardDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutColorLabel()
        layoutColorChangeButton()
        layoutAlphaLabel()
        layoutAlphaChangeSlider()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layoutColorLabel()
        layoutColorChangeButton()
        layoutAlphaLabel()
        layoutAlphaChangeSlider()
    }
    
    
    private func layoutColorLabel() {
        self.addSubview(colorLabel)
        self.colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.colorLabel.text = "배경색"
        
        self.colorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        self.colorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        self.colorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        self.colorLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func layoutColorChangeButton() {
        self.addSubview(colorChangeButton)
        self.colorChangeButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.colorChangeButton.layer.borderWidth = 1
        self.colorChangeButton.layer.borderColor = UIColor.black.cgColor
        self.colorChangeButton.layer.cornerRadius = 10
        self.colorChangeButton.setTitleColor(.black, for: .normal)
        self.colorChangeButton.setTitle("None", for: .disabled)
        self.colorChangeButton.setTitleColor(.gray, for: .disabled)
        
        self.colorChangeButton.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 10).isActive = true
        self.colorChangeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        self.colorChangeButton.leadingAnchor.constraint(equalTo: self.colorLabel.leadingAnchor).isActive = true
        self.colorChangeButton.trailingAnchor.constraint(equalTo: self.colorLabel.trailingAnchor).isActive = true
        
        self.colorChangeButton.addTarget(self, action: #selector(self.touchColorButton), for: .touchUpInside)
    }
    
    private func layoutAlphaLabel() {
        self.addSubview(alphaLabel)
        self.alphaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.alphaLabel.text = "투명도"
        
        self.alphaLabel.topAnchor.constraint(equalTo: self.colorChangeButton.bottomAnchor, constant: 40).isActive = true
        self.alphaLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        self.alphaLabel.leadingAnchor.constraint(equalTo: self.colorLabel.leadingAnchor).isActive = true
        self.alphaLabel.trailingAnchor.constraint(equalTo: self.colorLabel.trailingAnchor).isActive = true
    }
    
    private func layoutAlphaChangeSlider() {
        self.addSubview(alphaChangeSlider)
        self.alphaChangeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        self.alphaChangeSlider.minimumValue = 0.1
        self.alphaChangeSlider.maximumValue = 1
        
        self.alphaChangeSlider.topAnchor.constraint(equalTo: self.alphaLabel.bottomAnchor, constant: 10).isActive = true
        self.alphaChangeSlider.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        self.alphaChangeSlider.leadingAnchor.constraint(equalTo: self.colorLabel.leadingAnchor).isActive = true
        self.alphaChangeSlider.trailingAnchor.constraint(equalTo: self.colorLabel.trailingAnchor).isActive = true
        
        self.alphaChangeSlider.addTarget(self, action: #selector(self.moveAlphaSlider), for: .valueChanged)
    }
    
    func setPropertyBoard(with shape: Shape?) {
        guard let shape = shape else {
            self.alphaChangeSlider.value = self.alphaChangeSlider.minimumValue
            self.colorChangeButton.isEnabled = false
            return
        }
        
        let alpha = shape.alpha.transparency
        self.alphaChangeSlider.value = Float(alpha)
        switch shape {
        case is PhotoRectangle:
            self.colorChangeButton.isEnabled = false
        case is Rectangle:
            guard let rectangle = shape as? Rectangle else {return}
            let color = rectangle.backgroundColor
            self.colorChangeButton.isEnabled = true
            updateColorButton(color: color)
        default:
            return
        }
    }
    
    func updateColorButton(color : Color) {
        let red = Int(color.red * 255)
        let green = Int(color.green * 255)
        let blue = Int(color.blue * 255)
        self.colorChangeButton.setTitle("\(String(format: "#%02X%02X%02x", red, green, blue))", for: .normal)
    }
    
    @objc func moveAlphaSlider() {
        let updatedAlpha = Alpha(transparency: Double(self.alphaChangeSlider.value))
        delegate?.propertyChangeBoard(didChanged: updatedAlpha)
    }
    
    @objc func touchColorButton() {
        delegate?.propertyChangeBoardDidTouchedColorButton()
    }
}

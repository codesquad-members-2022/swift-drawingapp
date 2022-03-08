//
//  RectangleViewBoard.swift
//  DrawingApp
//
//  Created by dale on 2022/03/07.
//

import Foundation
import UIKit

protocol PropertyChangeBoardDelegate {
    func didUpdatedAlpha(alpha: Alpha)
    func didTouchedColorButton()
}

class PropertyChangeBoard : UIView {
    private let colorLabel = UILabel()
    private let colorChangeButton = UIButton()
    private let alphaLabel = UILabel()
    private let alphaChangeSlider = UISlider()
    var delegate : PropertyChangeBoardDelegate?
    
    var selectedRectangleView : RectangleView?
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetUp()
    }
    
    private func initialSetUp() {
        self.addSubview(colorLabel)
        self.addSubview(colorChangeButton)
        self.addSubview(alphaLabel)
        self.addSubview(alphaChangeSlider)
        
        let layoutColorLabel = {
            self.colorLabel.translatesAutoresizingMaskIntoConstraints = false

            self.colorLabel.text = "배경색"

            self.colorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
            self.colorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
            self.colorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
            self.colorLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        }
        
        let layoutColorChangeButton = {
            self.colorChangeButton.translatesAutoresizingMaskIntoConstraints = false
            
            self.colorChangeButton.layer.borderWidth = 1
            self.colorChangeButton.layer.borderColor = UIColor.black.cgColor
            self.colorChangeButton.layer.cornerRadius = 10
            self.colorChangeButton.setTitleColor(.black, for: .normal)
            
            self.colorChangeButton.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 10).isActive = true
            self.colorChangeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
            self.colorChangeButton.leadingAnchor.constraint(equalTo: self.colorLabel.leadingAnchor).isActive = true
            self.colorChangeButton.trailingAnchor.constraint(equalTo: self.colorLabel.trailingAnchor).isActive = true
            
            self.colorChangeButton.addTarget(self, action: #selector(self.touchButton), for: .touchUpInside)
        }
        
        let layoutAlphaLabel = {
            
            self.alphaLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.alphaLabel.text = "투명도"
            
            self.alphaLabel.topAnchor.constraint(equalTo: self.colorChangeButton.bottomAnchor, constant: 40).isActive = true
            self.alphaLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
            self.alphaLabel.leadingAnchor.constraint(equalTo: self.colorLabel.leadingAnchor).isActive = true
            self.alphaLabel.trailingAnchor.constraint(equalTo: self.colorLabel.trailingAnchor).isActive = true
        }
        
        let layoutAlphaChangeSlider = {
           
            self.alphaChangeSlider.translatesAutoresizingMaskIntoConstraints = false
            
            self.alphaChangeSlider.minimumValue = 1
            self.alphaChangeSlider.maximumValue = 10
            
            self.alphaChangeSlider.topAnchor.constraint(equalTo: self.alphaLabel.bottomAnchor, constant: 10).isActive = true
            self.alphaChangeSlider.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
            self.alphaChangeSlider.leadingAnchor.constraint(equalTo: self.colorLabel.leadingAnchor).isActive = true
            self.alphaChangeSlider.trailingAnchor.constraint(equalTo: self.colorLabel.trailingAnchor).isActive = true
            
            self.alphaChangeSlider.addTarget(self, action: #selector(self.moveSlider), for: .valueChanged)
        }
        
        layoutColorLabel()
        layoutColorChangeButton()
        layoutAlphaLabel()
        layoutAlphaChangeSlider()
    }
    
    func setPropertyBoard(with rectangleView: RectangleView?) {
        self.selectedRectangleView = rectangleView
        guard let alpha = self.selectedRectangleView?.alpha else {return}
        self.alphaChangeSlider.value = Float(Int(alpha * 10))
        updateColorButton()
    }
    
    func updateColorButton() {
        guard let color = self.selectedRectangleView?.backgroundColor?.cgColor.components else {
            return
        }
        let red = Int(color[0] * 255)
        let green = Int(color[1] * 255)
        let blue = Int(color[2] * 255)
        self.colorChangeButton.setTitle("\(String(format: "#%02X%02X%02x", red, green, blue))", for: .normal)
    }
    
    @objc func moveSlider() {
        guard let updatedAlpha = Alpha(transparency: Double(self.alphaChangeSlider.value/10)) else {return}
        delegate?.didUpdatedAlpha(alpha: updatedAlpha)
    }
    
    @objc func touchButton() {
        delegate?.didTouchedColorButton()
    }
}

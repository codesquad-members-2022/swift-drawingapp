//
//  inspectorView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

protocol InspectorDelegate {
    func changeColorButtonTapped()
    func alphaSliderValueChanged(alpha: Alpha?)
}

class InspectorView: UIView {
    private let itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let colorButton: InspectorItemButtonView = {
        let instpacorButton = InspectorItemButtonView()
        instpacorButton.title.text = "배경색"
        instpacorButton.translatesAutoresizingMaskIntoConstraints = false
        return instpacorButton
    }()
    
    private let alphaSlider: InspectorSliderView = {
        let instpacorSlider = InspectorSliderView()
        instpacorSlider.title.text = "Alpha"
        instpacorSlider.slider.minimumValue = 0
        instpacorSlider.slider.maximumValue = Float(Alpha.max.index - 1)
        instpacorSlider.translatesAutoresizingMaskIntoConstraints = false
        return instpacorSlider
    }()
    
    private var items: [InspectorItemView] {
        [colorButton, alphaSlider]
    }
    
    var delegate: InspectorDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
        layout()
    }
    
    private func bind() {
        colorButton.button.addAction(UIAction{ _ in
            self.delegate?.changeColorButtonTapped()
            }, for: .touchUpInside)
        
        alphaSlider.slider.addAction(UIAction{ _ in
            let alpha = Alpha.init(rawValue: Int(self.alphaSlider.slider.value))
            self.delegate?.alphaSliderValueChanged(alpha: alpha)
        }, for: .valueChanged)
    }
    
    private func layout() {
        self.addSubview(itemStackView)
        items.forEach {
            itemStackView.addArrangedSubview($0)
        }
        
        itemStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        itemStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        itemStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        itemStackView.bottomAnchor.constraint(equalTo: items[items.count - 1].bottomAnchor).isActive = true
    }
    
    func updateInspector(in square: Square?) {
        itemStackView.isHidden = square == nil
        
        guard let square = square else {
            return
        }
        
        let inspectorData = square.inspectorData
        colorButton.button.setTitle(inspectorData.hexColor, for: .normal)
        alphaSlider.setValue(Float(inspectorData.alpha.index))
    }
}

//
//  inspectorView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

protocol InspectorDelegate {
    func colorChange()
    func alphaChange(_ alpha: Alpha)
    func originMove(x: Double, y: Double)
    func sizeIncrease(width: Double, height: Double)
}

class InspectorView: UIView {
    
    private enum Constants {
        static let originMoveValue = 5.0
        static let sizeIncreaseValue = 5.0
    }
    
    private let itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let colorButton: InspectorItemButtonView = {
        let inspectorView = InspectorItemButtonView()
        inspectorView.title.text = "배경색"
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        return inspectorView
    }()
    
    private let alphaSlider: InspectorSliderView = {
        let inspectorView = InspectorSliderView()
        inspectorView.title.text = "Alpha"
        inspectorView.slider.minimumValue = 0
        inspectorView.slider.maximumValue = Float(Alpha.max.index)
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        return inspectorView
    }()
    
    private let originView: InspectorTwoUpDownView = {
        let inspectorView = InspectorTwoUpDownView()
        inspectorView.title.text = "위치"
        inspectorView.firstView.name.text = "X"
        inspectorView.secondView.name.text = "Y"
        return inspectorView
    }()
    
    private let sizeView: InspectorTwoUpDownView = {
        let inspectorView = InspectorTwoUpDownView()
        inspectorView.title.text = "크기"
        inspectorView.firstView.name.text = "W"
        inspectorView.secondView.name.text = "H"
        return inspectorView
    }()
    
    private var items: [InspectorItemView] {
        [colorButton, alphaSlider, originView, sizeView]
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
            self.delegate?.colorChange()
        }, for: .touchUpInside)
        
        alphaSlider.slider.addAction(UIAction{ _ in
            if let alpha = Alpha.init(rawValue: Int(self.alphaSlider.slider.value)) {
                self.delegate?.alphaChange(alpha)                
            }
        }, for: .valueChanged)
        
        //Origin
        originView.firstView.upButton.addAction(UIAction{ _ in
            self.delegate?.originMove(x: Constants.originMoveValue, y: 0)
        }, for: .touchUpInside)
        
        originView.firstView.downButton.addAction(UIAction{ _ in
            self.delegate?.originMove(x: -Constants.originMoveValue, y: 0)
        }, for: .touchUpInside)
        
        originView.secondView.upButton.addAction(UIAction{ _ in
            self.delegate?.originMove(x: 0, y: Constants.originMoveValue)
        }, for: .touchUpInside)
        
        originView.secondView.downButton.addAction(UIAction{ _ in
            self.delegate?.originMove(x: 0, y: -Constants.originMoveValue)
        }, for: .touchUpInside)
        
        //Size
        sizeView.firstView.upButton.addAction(UIAction{ _ in
            self.delegate?.sizeIncrease(width: Constants.sizeIncreaseValue, height: 0)
        }, for: .touchUpInside)
        
        sizeView.firstView.downButton.addAction(UIAction{ _ in
            self.delegate?.sizeIncrease(width: -Constants.sizeIncreaseValue, height: 0)
        }, for: .touchUpInside)
        
        sizeView.secondView.upButton.addAction(UIAction{ _ in
            self.delegate?.sizeIncrease(width: 0, height: Constants.sizeIncreaseValue)
        }, for: .touchUpInside)
        
        sizeView.secondView.downButton.addAction(UIAction{ _ in
            self.delegate?.sizeIncrease(width: 0, height: -Constants.sizeIncreaseValue)
        }, for: .touchUpInside)
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
    
    func update(model: DrawingModel) {
        self.update(alpha: model.alpha)
        self.update(size: model.size)
        self.update(origin: model.origin)
        
        switch model {
        case let model as RectangleModel:
            self.update(color: model.color)
        case model as PhotoModel:
            self.update(color: nil)
        default:
            break
        }
    }
    
    func update(color: Color?) {
        if let color = color {
            colorButton.button.setTitle(color.hexColor, for: .normal)
        } else {
            colorButton.button.setTitle("None", for: .normal)            
        }
    }
    
    func update(alpha: Alpha) {
        alphaSlider.setValue(Float(alpha.index))
    }
    
    func update(size: Size) {
        sizeView.firstView.value.text = String(format: "%.2f", size.width)
        sizeView.secondView.value.text = String(format: "%.2f", size.height)
    }
    
    func update(origin: Point) {
        originView.firstView.value.text = String(format: "%.2f", origin.x)
        originView.secondView.value.text = String(format: "%.2f", origin.y)
    }
}

//
//  inspectorView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

protocol InspectorDelegate {
    func changeColor()
    func changeAlpha(_ alpha: Alpha)
    func transform(translationX: Double, y: Double)
    func transform(width: Double, height: Double)
    func changeFont(name: String)
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
        stackView.isHidden = true
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
    
    private let fontButton: InspectorItemButtonView = {
        let inspectorView = InspectorItemButtonView()
        inspectorView.title.text = "Font"
        inspectorView.button.titleLabel?.adjustsFontSizeToFitWidth = true
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        return inspectorView
    }()
    
    private var items: [InspectorItemView] {
        [colorButton, alphaSlider, originView, sizeView, fontButton]
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
            self.delegate?.changeColor()
        }, for: .touchUpInside)
        
        alphaSlider.slider.addAction(UIAction{ _ in
            if let alpha = Alpha.init(rawValue: Int(self.alphaSlider.slider.value)) {
                self.delegate?.changeAlpha(alpha)                
            }
        }, for: .valueChanged)
        
        //Origin
        originView.firstView.upButton.addAction(UIAction{ _ in
            self.delegate?.transform(translationX: Constants.originMoveValue, y: 0)
        }, for: .touchUpInside)
        
        originView.firstView.downButton.addAction(UIAction{ _ in
            self.delegate?.transform(translationX: -Constants.originMoveValue, y: 0)
        }, for: .touchUpInside)
        
        originView.secondView.upButton.addAction(UIAction{ _ in
            self.delegate?.transform(translationX: 0, y: Constants.originMoveValue)
        }, for: .touchUpInside)
        
        originView.secondView.downButton.addAction(UIAction{ _ in
            self.delegate?.transform(translationX: 0, y: -Constants.originMoveValue)
        }, for: .touchUpInside)
        
        //Size
        sizeView.firstView.upButton.addAction(UIAction{ _ in
            self.delegate?.transform(width: Constants.sizeIncreaseValue, height: 0)
        }, for: .touchUpInside)
        
        sizeView.firstView.downButton.addAction(UIAction{ _ in
            self.delegate?.transform(width: -Constants.sizeIncreaseValue, height: 0)
        }, for: .touchUpInside)
        
        sizeView.secondView.upButton.addAction(UIAction{ _ in
            self.delegate?.transform(width: 0, height: Constants.sizeIncreaseValue)
        }, for: .touchUpInside)
        
        sizeView.secondView.downButton.addAction(UIAction{ _ in
            self.delegate?.transform(width: 0, height: -Constants.sizeIncreaseValue)
        }, for: .touchUpInside)
        
        let fontMenus: [UIAction] =
        Font.names.map { name in
            UIAction(title: name, image: nil, handler: { _ in
                self.delegate?.changeFont(name: name)
            })
        }
        
        fontButton.button.menu = UIMenu(title: "Font", image: nil, identifier: nil, options: .displayInline, children: fontMenus)
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
    
    func setHidden(_ hidden: Bool) {
        self.itemStackView.isHidden = hidden
    }
    
    func update(model: DrawingModel) {
        self.update(alpha: model.alpha)
        self.update(size: model.size)
        self.update(origin: model.origin)
        
        switch model {
        case let model as RectangleModel:
            self.update(color: model.color)
        case let model as LabelModel:
            self.update(color: nil)
            self.update(font: model.font)
        default:
            self.update(color: nil)
            break
        }
        
        self.fontButton.isHidden = (model as? LabelModel) == nil
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
        sizeView.firstView.value.text = String(format: "%.1f", size.width)
        sizeView.secondView.value.text = String(format: "%.1f", size.height)
    }
    
    func update(origin: Point) {
        originView.firstView.value.text = String(format: "%.1f", origin.x)
        originView.secondView.value.text = String(format: "%.1f", origin.y)
    }
    
    func update(font: Font) {
        fontButton.button.setTitle("\(font.name)", for: .normal)
    }
}

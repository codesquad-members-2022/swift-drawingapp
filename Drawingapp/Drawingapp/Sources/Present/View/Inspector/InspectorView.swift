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
    
    let leftBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
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
        inspectorView.setMinMaxValue(min: 0, max: Float(Alpha.max.index))
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        return inspectorView
    }()
    
    private let originView: InspectorTwoUpDownView = {
        let inspectorView = InspectorTwoUpDownView()
        inspectorView.title.text = "위치"
        inspectorView.setTitles(firstTitle: "X", secondTitle: "Y")
        return inspectorView
    }()
    
    private let sizeView: InspectorTwoUpDownView = {
        let inspectorView = InspectorTwoUpDownView()
        inspectorView.title.text = "크기"
        inspectorView.setTitles(firstTitle: "W", secondTitle: "H")
        return inspectorView
    }()
    
    private let fontButton: InspectorItemButtonView = {
        let inspectorView = InspectorItemButtonView()
        inspectorView.title.text = "Font"
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
        colorButton.bind {
            self.delegate?.changeColor()
        }
        
        alphaSlider.bind {
            if let alpha = Alpha.init(rawValue: Int($0)) {
                self.delegate?.changeAlpha(alpha)
            }
        }
        
        originView.bind { viewType, buttonType in
            if viewType == .first {
                self.delegate?.transform(translationX: Constants.originMoveValue * (buttonType == .up ? 1 : -1), y: 0)
            } else {
                self.delegate?.transform(translationX: 0, y: Constants.originMoveValue * (buttonType == .up ? 1 : -1))
            }
        }
        
        sizeView.bind { viewType, buttonType in
            if viewType == .first {
                self.delegate?.transform(width: Constants.originMoveValue * (buttonType == .up ? 1 : -1), height: 0)
            } else {
                self.delegate?.transform(width: 0, height: Constants.originMoveValue * (buttonType == .up ? 1 : -1))
            }
        }
        
        let fontMenus: [UIAction] =
        Font.names.map { name in
            UIAction(title: name, image: nil, handler: { _ in
                self.delegate?.changeFont(name: name)
            })
        }
        
        fontButton.addMenu(menu: UIMenu(title: "Font", image: nil, identifier: nil, options: .displayInline, children: fontMenus))
    }
    
    private func layout() {
        self.addSubview(leftBar)
        self.addSubview(itemStackView)
        items.forEach {
            itemStackView.addArrangedSubview($0)
        }
        
        itemStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        itemStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        itemStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        itemStackView.bottomAnchor.constraint(equalTo: items[items.count - 1].bottomAnchor).isActive = true
        
        leftBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftBar.widthAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setHidden(_ hidden: Bool) {
        self.itemStackView.isHidden = hidden
    }
    
    func update(model: Drawingable) {
        self.update(alpha: model.alpha)
        self.update(size: model.size)
        self.update(origin: model.origin)
        
        switch model {
        case let model as Colorable:
            self.update(color: model.color)
        case let model as Textable:
            self.update(color: nil)
            self.update(fontName: model.font.name)
        default:
            self.update(color: nil)
            break
        }
        
        self.fontButton.isHidden = (model as? Textable) == nil
    }
    
    func update(color: Color?) {
        if let color = color {
            colorButton.setTitle(title: color.hexColor)
        } else {
            colorButton.setTitle(title: "None")
        }
    }
    
    func update(alpha: Alpha) {
        alphaSlider.setValue(Float(alpha.index))
    }
    
    func update(size: Size) {
        sizeView.setValues(firstValue: String(format: "%.1f", size.width), secondValue: String(format: "%.1f", size.height))
    }
    
    func update(origin: Point) {
        originView.setValues(firstValue: String(format: "%.1f", origin.x), secondValue: String(format: "%.1f", origin.y))
    }
    
    func update(fontName: String) {
        fontButton.setTitle(title: "\(fontName)")
    }
}

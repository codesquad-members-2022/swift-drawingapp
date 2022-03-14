//
//  LabelView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation
import UIKit

class LabelView: DrawingView, Textable {
    private let labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    required init(model: DrawingModel) {
        super.init(model: model)
        if let labelModel = model as? LabelModel {
            self.update(text: labelModel.text)
            self.update(font: labelModel.font)
            self.update(fontColor: labelModel.fontColor)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layout() {
        super.layout()
        self.canvasView.addSubview(labelView)
        self.labelView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.labelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.labelView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.labelView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func update(text: String) {
        self.labelView.text = text
        self.labelView.sizeToFit()
    }
    
    func update(font: Font) {
        guard let uiFont = UIFont(name: font.name, size: font.size) else {
                  return
              }
        self.labelView.font = uiFont
    }
    
    func update(fontColor: Color) {
        labelView.textColor = UIColor(red: CGFloat(fontColor.r) / 255, green: CGFloat(fontColor.g) / 255, blue: CGFloat(fontColor.b / 255), alpha: 1)
    }
}

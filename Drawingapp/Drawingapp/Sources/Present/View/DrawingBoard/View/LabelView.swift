//
//  LabelView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation
import UIKit

class LabelView: DrawingView {
    private let labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    required init(drawingable: Drawingable) {
        super.init(drawingable: drawingable)
        if let textable = drawingable as? Labelable {
            self.update(text: textable.text)
            self.update(font: textable.font)
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
}

extension LabelView: TextUpdatable {
    func update(text: String) {
        self.labelView.text = text
        self.labelView.sizeToFit()
    }
}

extension LabelView: FontUpdatable {
    func update(fontSize: Double) {
        guard let uiFont = UIFont(name: self.labelView.font.fontName, size: fontSize) else {
                  return
              }
        self.labelView.font = uiFont
    }
    
    func update(font: Font) {
        guard let uiFont = UIFont(name: font.name, size: font.size) else {
                  return
              }
        self.labelView.font = uiFont
    }
    
    func update(fontName: String) {
        guard let uiFont = UIFont(name: fontName, size: self.labelView.font.pointSize) else {
                  return
              }
        self.labelView.font = uiFont
    }
}

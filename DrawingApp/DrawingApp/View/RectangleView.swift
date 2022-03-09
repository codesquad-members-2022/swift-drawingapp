//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/09.
//

import UIKit

class RectangleView: UIView {
    
    private var isHighlighted: Bool = false
    
    //MARK: Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = color
    }
    
    //MARK: Configure Components
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func highlightCorner() {
        layer.borderColor = UIColor.systemCyan.cgColor
        layer.borderWidth = 5
        isHighlighted = true
    }
    
    func clearCorner() {
        layer.borderWidth = 0
        layer.borderColor = .none
        isHighlighted = false
    }
    
    func toggleCorner() {
        isHighlighted ? clearCorner() : highlightCorner()
    }
}

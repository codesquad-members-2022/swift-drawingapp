//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/09.
//

import UIKit

class RectangleView: UIView {
    
    //MARK: Initialize
    private var isHighlighted: Bool = false
    
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
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func highlightCorner() {
        self.layer.borderColor = UIColor.systemCyan.cgColor
        self.layer.borderWidth = 5
        self.isHighlighted = true
    }
    
    func clearCorner() {
        self.layer.borderWidth = 0
        self.layer.borderColor = .none
        self.isHighlighted = false
    }
    
    func toggleCorner() {
        self.isHighlighted ? self.clearCorner() : self.highlightCorner()
    }
    
}

//
//  PanelView.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import Foundation
import UIKit

class PanelView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSubViews()
    }
    
  
    
    private func loadSubViews() {
        self.backgroundColor = UIColor.systemGray3
        
        let colorLabel = makeLabel()
        let alphaLabel = makeLabel()
        let colorRondomizeButton = ColorRondomizeButton()
        
        colorLabel.text = "배경색"
        alphaLabel.text = "투명도"
        colorRondomizeButton.frame = CGRect(x: self.bounds.minX+20, y: self.bounds.minY+70, width: 160, height: 50)
        colorLabel.frame = CGRect(x: self.bounds.minX+20, y: self.bounds.minY+20, width: 160, height: 50)
        alphaLabel.frame = CGRect(x: self.bounds.minX+20, y: self.bounds.minY+150, width: 160, height: 50)
        
        addSubview(colorLabel)
        addSubview(alphaLabel)
        addSubview(colorRondomizeButton)
    }
    
    
    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        
        return label
        
    }
    
}

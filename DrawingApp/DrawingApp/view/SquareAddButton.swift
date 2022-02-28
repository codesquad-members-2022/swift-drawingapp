//
//  SquareAddButton.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation
import UIKit

class SquareAddButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSquareAddButtonProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var shapeImageView = UIImageView(frame: CGRect(x: 25, y: 20, width: 50, height: 40))
    private lazy var shapeNameLabel = UILabel(frame: CGRect(x: 10, y: 60, width: 80, height: 30))
    
    private func setSquareAddButtonProperty(){
        backgroundColor = .white
        setShapeImageViewProperty()
        setShapeNameLabelProperty()
        setButtonLayer()
        addSubview(shapeImageView)
        addSubview(shapeNameLabel)
    }
    
    private func setShapeImageViewProperty(){
        shapeImageView.image = UIImage(systemName: "square")
    }

    private func setShapeNameLabelProperty(){
        shapeNameLabel.text = "사각형"
        shapeNameLabel.textAlignment = .center
    }
    
    private func setButtonLayer(){
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 10.0
    }
}

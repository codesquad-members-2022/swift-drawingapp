//
//  RightAttributer.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import UIKit

class RightAttributerView: UIView {
    let colorTitle = UILabel()
    let alphaTitle = UILabel()
    
    private var colorName = UILabel()
    private var alphaSlider = UISlider()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize(){
        attribute()
    }
    
    private func attribute(){
        self.backgroundColor = .systemGray5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        
        colorTitle.textColor = .black
        colorTitle.font = .systemFont(ofSize: 17)
        colorTitle.text = "배경색"
        alphaTitle.textColor = .black
        alphaTitle.font = .systemFont(ofSize: 17)
        alphaTitle.text = "투명도"
        
        colorName.layer.borderColor = UIColor.darkGray.cgColor
        colorName.layer.borderWidth = 1
        colorName.layer.cornerRadius = 10
        colorName.textColor = .darkGray
        colorName.font = .systemFont(ofSize: 18)
        colorName.textAlignment = .center
        colorName.text = "No select"
        
        alphaSlider.minimumValue = Float(Alpha.one.showValue())
        alphaSlider.maximumValue = Float(Alpha.ten.showValue())
    }
    
    func layout(){
        self.frame = CGRect(x: 1030, y: 0, width: 150, height: 820)
        
        colorTitle.frame = CGRect(x: 25, y: 40, width: 70, height: 30)
        colorName.frame = CGRect(x: 25, y: 80, width: 100, height: 40)
        alphaTitle.frame = CGRect(x: 25, y: 150, width: 70, height: 30)
        alphaSlider.frame = CGRect(x: 25, y: 190, width: 100, height: 30)
        
        self.addSubview(colorTitle)
        self.addSubview(colorName)
        self.addSubview(alphaTitle)
        self.addSubview(alphaSlider)
    }
}

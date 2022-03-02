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
    
    private var colorNameRed = UILabel()
    private var colorNameGreen = UILabel()
    private var colorNameBlue = UILabel()
    
    private var redSlider = UISlider()
    private var greenSlider = UISlider()
    private var blueSlider = UISlider()
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
        
        colorNameRed.textColor = .red
        colorNameRed.font = .systemFont(ofSize: 15)
        colorNameRed.text = "Red"
        colorNameGreen.textColor = .green
        colorNameGreen.font = .systemFont(ofSize: 15)
        colorNameGreen.text = "Green"
        colorNameBlue.textColor = .blue
        colorNameBlue.font = .systemFont(ofSize: 15)
        colorNameBlue.text = "Blue"
        
        redSlider.minimumValue = 0
        redSlider.maximumValue = 255
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 255
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 255
        alphaSlider.minimumValue = Float(Alpha.one.showValue())
        alphaSlider.maximumValue = Float(Alpha.ten.showValue())
    }
    
    func layout(){
        self.frame = CGRect(x: 1030, y: 0, width: 150, height: 820)
        
        colorTitle.frame = CGRect(x: 15, y: 40, width: 120, height: 30)
        colorNameRed.frame = CGRect(x: 15, y: 70, width: 120, height: 30)
        redSlider.frame = CGRect(x: 15, y: 100, width: 100, height: 30)
        colorNameGreen.frame = CGRect(x: 15, y: 140, width: 120, height: 30)
        greenSlider.frame = CGRect(x: 15, y: 170, width: 100, height: 30)
        colorNameBlue.frame = CGRect(x: 15, y: 210, width: 120, height: 30)
        blueSlider.frame = CGRect(x: 15, y: 240, width: 100, height: 30)
        alphaTitle.frame = CGRect(x: 15, y: 290, width: 120, height: 30)
        alphaSlider.frame = CGRect(x: 15, y: 330, width: 120, height: 30)
        
        self.addSubview(colorTitle)
        self.addSubview(colorNameRed)
        self.addSubview(colorNameGreen)
        self.addSubview(colorNameBlue)
        self.addSubview(redSlider)
        self.addSubview(greenSlider)
        self.addSubview(blueSlider)
        self.addSubview(alphaTitle)
        self.addSubview(alphaSlider)
    }
    
    func changeAlphaSliderValue(value: Float){
        let alphaValue = String(format: "%.0f", value * 10)
        self.alphaSlider.value = Float(value)
        self.alphaTitle.text = "투명도 : \(alphaValue)"
    }
    
    func changeRedSliderValue(value: Float){
        let redValue = String(format: "%.0f", value)
        self.redSlider.value = Float(value)
        self.colorNameRed.text = "Red : \(redValue)"
    }
    
    func changeGreenSliderValue(value: Float){
        let greenValue = String(format: "%.0f", value)
        self.greenSlider.value = Float(value)
        self.colorNameGreen.text = "Green : \(greenValue)"
    }
    
    func changeBlueSliderValue(value: Float){
        let blueValue = String(format: "%.0f", value)
        self.blueSlider.value = Float(value)
        self.colorNameBlue.text = "Blue : \(blueValue)"
    }
}

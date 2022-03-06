//
//  RightAttributer.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import UIKit

class RightAttributerView: UIView {
    private let colorTitle = UILabel()
    private let alphaTitle = UILabel()
    
    private let colorNameRed = UILabel()
    private let colorNameGreen = UILabel()
    private let colorNameBlue = UILabel()
    
    let redSlider = UISlider()
    let greenSlider = UISlider()
    let blueSlider = UISlider()
    let alphaSlider = UISlider()
    
    var redValue: Double{
        return Double(redSlider.value)
    }
    var greenValue: Double{
        return Double(greenSlider.value)
    }
    var blueValue: Double{
        return Double(blueSlider.value)
    }
    var alphaValue: Alpha{
        let doubleValue = round(Double(alphaSlider.value) * 10) / 10
        let value = Alpha.init(rawValue: doubleValue)
    
        return value ?? .one
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
}


// MARK: - Use case: Make Rectangle with attrbute and layout, delegate

extension RightAttributerView{
    private func initialize(){
        attribute()
        layout()
        addSliderTargets()
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
        alphaSlider.minimumValue = 0.1
        alphaSlider.maximumValue = 1.0
    }
    
    private func layout(){
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
    
    private func addSliderTargets(){
        alphaSlider.addTarget(self, action: #selector(notifyAlpha), for: .valueChanged)
        redSlider.addTarget(self, action: #selector(notifyRed), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(notifyGreen), for: .valueChanged)
        blueSlider.addTarget(self, action: #selector(notifyBlue), for: .valueChanged)
    }
}


// MARK: - Use case: Change slider value

extension RightAttributerView{
    func originSliderValue(red: Float, green: Float, blue: Float, alpha: Float){
        self.alphaSlider.value = alpha
        self.alphaTitle.text = "투명도 : \(String(format: "%.0f", alphaValue.showValue() * 10))"
        
        self.redSlider.value = red
        self.colorNameRed.text = "Red : \(String(format: "%.0f", redValue))"
        
        self.greenSlider.value = green
        self.colorNameGreen.text = "Green : \(String(format: "%.0f", greenValue))"
        
        self.blueSlider.value = blue
        self.colorNameBlue.text = "Blue : \(String(format: "%.0f", blueValue))"
    }
    
    func changeColorSliderValue(text: String){
        if text.contains("Red"){
            colorNameRed.text = text
        } else if text.contains("Green"){
            colorNameGreen.text = text
        } else if text.contains("Blue"){
            colorNameBlue.text = text
        }
    }
    
    func changeAlphaSliderView(text: String){
        alphaTitle.text = text
    }
    
    @objc func notifyAlpha(){
        NotificationCenter.default.post(name: .changeAlpha, object: nil)
    }
    
    @objc func notifyRed(){
        NotificationCenter.default.post(name: .changeRedColor, object: nil)
    }
    
    @objc func notifyGreen(){
        NotificationCenter.default.post(name: .changeGreenColor, object: nil)
    }
    
    @objc func notifyBlue(){
        NotificationCenter.default.post(name: .changeBlueColor, object: nil)
    }
}

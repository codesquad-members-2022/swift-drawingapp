//
//  RightAttributer.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import UIKit

final class RightAttributerView: UIView {
    private let colorTitle = UILabel()
    private let alphaTitle = UILabel()
    private let positonTitle = UILabel()
    private let sizeTitle = UILabel()
    
    private let colorNameRed = UILabel()
    private let colorNameGreen = UILabel()
    private let colorNameBlue = UILabel()
    
    private let redSlider = UISlider()
    private let greenSlider = UISlider()
    private let blueSlider = UISlider()
    private let alphaSlider = UISlider()

    private let xPositionStepper = UIStepper()
    private let yPositionStepper = UIStepper()
    private let widthStepper = UIStepper()
    private let heightStepper = UIStepper()
    
    private let xPositionLabel = UILabel()
    private let yPositionLabel = UILabel()
    private let widthLabel = UILabel()
    private let heightLabel = UILabel()
    
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
    
    var xValue: Double{
        return xPositionStepper.value
    }
    var yValue: Double{
        return yPositionStepper.value
    }
    var widthValue: Double{
        return widthStepper.value
    }
    var heightValue: Double{
        return heightStepper.value
    }
    
    var sliderDelegate: UIColorSliderDelegate?
    var stepperDelegate: StepperDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
}


// MARK: - Use case: Make views with attrbute and layout

extension RightAttributerView{
    private func initialize(){
        attribute()
        layout()
        addSliderTargets()
        addStepperTargets()
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
        alphaTitle.text = "투명도 : 10"
        positonTitle.textColor = .black
        positonTitle.font = .systemFont(ofSize: 17)
        positonTitle.text = "위치"
        sizeTitle.textColor = .black
        sizeTitle.font = .systemFont(ofSize: 17)
        sizeTitle.text = "크기"
        
        colorNameRed.textColor = .red
        colorNameRed.font = .systemFont(ofSize: 15)
        colorNameRed.text = "Red : 0"
        colorNameGreen.textColor = .green
        colorNameGreen.font = .systemFont(ofSize: 15)
        colorNameGreen.text = "Green : 0"
        colorNameBlue.textColor = .blue
        colorNameBlue.font = .systemFont(ofSize: 15)
        colorNameBlue.text = "Blue : 0"
        
        redSlider.minimumValue = 0
        redSlider.maximumValue = 255
        redSlider.isContinuous = false
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 255
        greenSlider.isContinuous = false
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 255
        blueSlider.isContinuous = false
        alphaSlider.minimumValue = 0.1
        alphaSlider.maximumValue = 1
        alphaSlider.value = 1
        alphaSlider.isContinuous = false
        
        widthStepper.minimumValue = 1
        widthStepper.maximumValue = 150
        widthStepper.stepValue = 1
        heightStepper.minimumValue = 1
        heightStepper.maximumValue = 120
        heightStepper.stepValue = 1
        xPositionStepper.minimumValue = 1
        xPositionStepper.stepValue = 1
        yPositionStepper.minimumValue = 30
        yPositionStepper.stepValue = 1
        
        xPositionLabel.font = .systemFont(ofSize: 15)
        xPositionLabel.text = "\(String(format: "%.0f", xValue))"
        xPositionLabel.textAlignment = .center
        yPositionLabel.font = .systemFont(ofSize: 15)
        yPositionLabel.text = "\(String(format: "%.0f", yValue))"
        yPositionLabel.textAlignment = .center
        widthLabel.font = .systemFont(ofSize: 15)
        widthLabel.text = "\(String(format: "%.0f", widthValue))"
        widthLabel.textAlignment = .center
        heightLabel.font = .systemFont(ofSize: 15)
        heightLabel.text = "\(String(format: "%.0f", heightValue))"
        heightLabel.textAlignment = .center
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
        positonTitle.frame = CGRect(x: 15, y: 370, width: 120, height: 30)
        xPositionLabel.frame = CGRect(x: 15, y: 400, width: 35, height: 30)
        xPositionStepper.frame = CGRect(x: 50, y: 400, width: 100, height: 30)
        yPositionLabel.frame = CGRect(x: 15, y: 440, width: 35, height: 30)
        yPositionStepper.frame = CGRect(x: 50, y: 440, width: 100, height: 30)
        sizeTitle.frame = CGRect(x: 15, y: 480, width: 120, height: 30)
        widthLabel.frame = CGRect(x: 15, y: 510, width: 35, height: 30)
        widthStepper.frame = CGRect(x: 50, y: 510, width: 100, height: 30)
        heightLabel.frame = CGRect(x: 15, y: 550, width: 35, height: 30)
        heightStepper.frame = CGRect(x: 50, y: 550, width: 100, height: 30)
        
        self.addSubview(colorTitle)
        self.addSubview(colorNameRed)
        self.addSubview(colorNameGreen)
        self.addSubview(colorNameBlue)
        self.addSubview(redSlider)
        self.addSubview(greenSlider)
        self.addSubview(blueSlider)
        self.addSubview(alphaTitle)
        self.addSubview(alphaSlider)
        self.addSubview(positonTitle)
        self.addSubview(xPositionLabel)
        self.addSubview(xPositionStepper)
        self.addSubview(yPositionLabel)
        self.addSubview(yPositionStepper)
        self.addSubview(sizeTitle)
        self.addSubview(widthLabel)
        self.addSubview(widthStepper)
        self.addSubview(heightLabel)
        self.addSubview(heightStepper)
    }
}


// MARK: - Use case: Add Slider action

extension RightAttributerView{
    private func addSliderTargets(){
        alphaSlider.addTarget(self, action: #selector(moveAlphaSlider), for: .valueChanged)
        redSlider.addTarget(self, action: #selector(moveRedSlider), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(moveGreenSlider), for: .valueChanged)
        blueSlider.addTarget(self, action: #selector(moveBlueSlider), for: .valueChanged)
    }
    
    @objc private func moveAlphaSlider(){
        self.sliderDelegate?.alphaSliderDidMove()
    }
    
    @objc private func moveRedSlider(){
        self.sliderDelegate?.redSliderDidMove()
    }
    
    @objc private func moveGreenSlider(){
        self.sliderDelegate?.greenSliderDidMove()
    }
    
    @objc private func moveBlueSlider(){
        self.sliderDelegate?.blueSliderDidMove()
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
}


// MARK: - Use case: Add Stepper action

extension RightAttributerView{
    private func addStepperTargets(){
        xPositionStepper.addTarget(self, action: #selector(changePointValue), for: .valueChanged)
        yPositionStepper.addTarget(self, action: #selector(changePointValue), for: .valueChanged)
        widthStepper.addTarget(self, action: #selector(changeSizeValue), for: .valueChanged)
        heightStepper.addTarget(self, action: #selector(changeSizeValue), for: .valueChanged)
    }
    
    @objc private func changePointValue(){
        self.stepperDelegate?.pointValueDidChange()
    }
    
    @objc private func changeSizeValue(){
        self.stepperDelegate?.sizeValueDidChange()
    }
}


// MARK: - Use case: Change Stepper value

extension RightAttributerView{
    func setViewPositionMaxValue(maxX: Double, maxY: Double){
        self.yPositionStepper.maximumValue = maxY - 120
        self.xPositionStepper.maximumValue = maxX - 150
    }
    
    func originStepperValue(x: Double, y: Double, width: Double, height: Double){
        self.xPositionStepper.value = x
        self.xPositionLabel.text = "\(String(format: "%.0f", xValue))"
        self.yPositionStepper.value = y
        self.yPositionLabel.text = "\(String(format: "%.0f", yValue))"
        self.widthStepper.value = width
        self.widthLabel.text = "\(String(format: "%.0f", widthValue))"
        self.heightStepper.value = height
        self.heightLabel.text = "\(String(format: "%.0f", heightValue))"
    }
    
    func changeStepperValue(){
        self.xPositionLabel.text = "\(String(format: "%.0f", xValue))"
        self.yPositionLabel.text = "\(String(format: "%.0f", yValue))"
        self.widthLabel.text = "\(String(format: "%.0f", widthValue))"
        self.heightLabel.text = "\(String(format: "%.0f", heightValue))"
    }
    
    func onlyChangePositionValue(x: CGFloat, y: CGFloat){
        self.xPositionLabel.text = "\(String(format: "%.0f", x))"
        self.yPositionLabel.text = "\(String(format: "%.0f", y))"
    }
}


// MARK: - Use case: Slider View disable

extension RightAttributerView{
    func rockColorSlider(){
        redSlider.isEnabled = false
        greenSlider.isEnabled = false
        blueSlider.isEnabled = false
    }
    
    func rockAlphaSlider(){
        alphaSlider.isEnabled = false
    }
    
    func useColorSlider(){
        redSlider.isEnabled = true
        greenSlider.isEnabled = true
        blueSlider.isEnabled = true
    }
    
    func useAlphaSlider(){
        alphaSlider.isEnabled = true
    }
}

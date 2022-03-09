//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var plane = Plane()
    private var rectangleAndViewMap = [Rectangle: RectangleView]()
    weak var generateRectangleButton: UIButton!
    weak var drawableAreaView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var minusAlphaValueButton: UIButton!
    @IBOutlet weak var plusAlphaValueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundColorButton.setTitle("배경색 버튼", for: .disabled)
        
        addGenerateRectangleButton()
        addDrawableAreaView()
        plane.delegate = self
        
        initializeViewsInTouchedEmptySpaceCondition()
        
    }
    
    func addGenerateRectangleButton() {
        let buttonUIAction = UIAction { _ in
            let pointLimit = (Double(self.drawableAreaView.frame.width),
                              Double(self.drawableAreaView.frame.height))
            self.plane.addNewRectangle(in: pointLimit)
        }
        let generateButton = UIButton(type: .custom, primaryAction: buttonUIAction)
        let buttonWidth = 100.0
        let buttonHeight = 100.0
        let buttonX = (self.view.frame.size.width/2.0) - (buttonWidth/2.0)
        let buttonY = self.view.frame.size.height - buttonHeight
        generateButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        generateButton.backgroundColor = .gray
        generateButton.setTitle("사각형 생성", for: .normal)
        
        self.generateRectangleButton = generateButton
        self.view.addSubview(generateButton)
    }
    
    func addDrawableAreaView() {
        let drawableViewX = self.view.frame.origin.x
        let drawableViewY = self.view.frame.origin.y
        let drawableViewWidth = self.view.frame.width - self.statusView.frame.width
        let generateButtonHeight = 100.0
        let drawableViewHeight = self.view.frame.height - generateButtonHeight
        let drawableAreaView = UIView(frame: CGRect(x: drawableViewX, y: drawableViewY, width: drawableViewWidth, height: drawableViewHeight))
        drawableAreaView.clipsToBounds = true
        
        self.drawableAreaView = drawableAreaView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTouched(sender:)))
        drawableAreaView.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(drawableAreaView)
    }
    
    @objc func viewDidTouched(sender: UITapGestureRecognizer) {
        initializeViewsInTouchedEmptySpaceCondition()
        
        let touchedLocation = sender.location(in: drawableAreaView)
        let touchedPoint = Point(x: touchedLocation.x, y: touchedLocation.y)
        
        plane.specifyRectangle(point: touchedPoint)
    }
    
    private func initializeViewsInTouchedEmptySpaceCondition() {
        backgroundColorButton.isEnabled = false
        backgroundColorButton.backgroundColor = .clear
        alphaSlider.isEnabled = false
        let alphaSliderCenterValue = (alphaSlider.minimumValue + alphaSlider.maximumValue) / 2
        alphaSlider.setValue(alphaSliderCenterValue, animated: true)
        minusAlphaValueButton.isEnabled = false
        minusAlphaValueButton.backgroundColor = .systemGray6
        plusAlphaValueButton.isEnabled = false
        plusAlphaValueButton.backgroundColor = .systemGray6
    }
    
    @IBAction func backgroundButtonTouched(_ sender: UIButton) {
        plane.changeBackGroundColor()
    }
    
    @IBAction func alphaSliderValueChanged(_ sender: UISlider) {
        let newAlphaValue = Double(round(sender.value * 10) / 10.0)
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: newAlphaValue) else {return}
        let newAlpha = Alpha(opacityLevel: convertedOpacityLevel)
        
        plane.changeAlphaValue(to: newAlpha)
    }
    
    @IBAction func minusAlphaValueButtonTouched(_ sender: UIButton) {
        plane.stepDownAlphaValue()
    }
    @IBAction func plusAlphaValueButtonTouched(_ sender: UIButton) {
        plane.stepUpAlphaValue()
    }
    
}

extension ViewController: PlaneDelegate {
    func rectangleDidAdded(_ rectangle: Rectangle) {
        os_log("\(rectangle)")
        
        let newRectangleView = ViewFactory.generateRectangleView(of: rectangle)
        self.drawableAreaView.addSubview(newRectangleView)
        rectangleAndViewMap[rectangle] = newRectangleView
    }
    
    func rectangleDidSpecified(_ specifiedRectangle: Rectangle) {
        guard let matchedView = rectangleAndViewMap[specifiedRectangle] else {
            return
        }
        
        updateSelectedView(matchedView)
        updateBackgroundButton(color: specifiedRectangle.backgroundColor, alpha: specifiedRectangle.alpha)
        updateAlphaSlider(alpha: matchedView.alpha)
        updateMinusAlphaValueButton(with: matchedView.alpha)
        updatePlusAlphaValueButton(with: matchedView.alpha)
    }
    
    func rectangleBackgroundColorDidChanged(_ backgroundColorChangedRectangle: Rectangle) {
        guard let matchedView = rectangleAndViewMap[backgroundColorChangedRectangle] else {
            return
        }
        
        let newBackgroundColor = backgroundColorChangedRectangle.backgroundColor
        matchedView.backgroundColor = newBackgroundColor.convertToUIColor()
        let previousnAlpha = backgroundColorChangedRectangle.alpha
        updateBackgroundButton(color: newBackgroundColor, alpha: previousnAlpha)
    }
    
    func rectangleAlphaDidChanged(_ alphaChangedRectangle: Rectangle) {
        guard let matchedView = rectangleAndViewMap[alphaChangedRectangle] else {
            return
        }
        
        let newAlphaValue = alphaChangedRectangle.alpha.value
        matchedView.alpha = CGFloat(newAlphaValue)
        updateStatusViewElement(with: newAlphaValue)
    }
    
    private func updateSelectedView(_ selectedView: RectangleView) {
        drawableAreaView.subviews.forEach { rectangleView in
            rectangleView.layer.borderWidth = 0
        }
        
        selectedView.layer.borderWidth = 3
        selectedView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func updateBackgroundButton(color: BackgroundColor, alpha: Alpha) {
        backgroundColorButton.isEnabled = true
        backgroundColorButton.setTitle(color.hexCode, for: .normal)
        let buttonBackgroundColor = color.convertToUIColor(with: alpha.value)
        backgroundColorButton.backgroundColor = buttonBackgroundColor
    }
    
    private func updateStatusViewElement(with alpha: Float) {
        updateBackgroundColorButtonAlpha(with: CGFloat(alpha))
        updateAlphaSlider(alpha: alpha)
        updateMinusAlphaValueButton(with: alpha)
        updatePlusAlphaValueButton(with: alpha)
    }
    
    private func updateBackgroundColorButtonAlpha(with newAlpha: CGFloat) {
        let previousBackgroundColorButtonColor = backgroundColorButton.backgroundColor ?? UIColor()
        self.backgroundColorButton.backgroundColor = previousBackgroundColorButtonColor.withAlphaComponent(newAlpha)
    }
    
    private func updateMinusAlphaValueButton(with alpha: Float) {
        if round(alpha * 10) / 10.0 > 0.1 {
            minusAlphaValueButton.isEnabled = true
            minusAlphaValueButton.backgroundColor = .white
        } else {
            minusAlphaValueButton.isEnabled = false
            minusAlphaValueButton.backgroundColor = .systemGray6
        }
    }
    
    private func updatePlusAlphaValueButton(with alpha: Float) {
        if round(alpha * 10) / 10.0 < 1.0 {
            plusAlphaValueButton.isEnabled = true
            plusAlphaValueButton.backgroundColor = .white
        } else {
            plusAlphaValueButton.isEnabled = false
            plusAlphaValueButton.backgroundColor = .systemGray6
        }
    }
    
    private func updateAlphaSlider(alpha: Float) {
        alphaSlider.isEnabled = true
        alphaSlider.setValue(Float(alpha), animated: true)
    }
}

extension BackgroundColor {
    fileprivate func convertToUIColor(with alphaValue: Double = 1.0) -> UIColor {
        let convertedRed = Double(self.r) / 255.0
        let convertedGreen = Double(self.g) / 255.0
        let convertedBlue = Double(self.b) / 255.0
        
        return UIColor(red: convertedRed, green: convertedGreen, blue: convertedBlue, alpha: alphaValue)
    }
}

//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    let plane = Plane()
    weak var generateRectangleButton: UIButton!
    weak var drawableAreaView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var minusAlphaValueButton: UIButton!
    @IBOutlet weak var plusAlphaValueButton: UIButton!
    
    
    weak var touchedView: RectangleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundColorButton.setTitle("배경색 버튼", for: .disabled)
        
        addGenerateRectangleButton()
        addDrawableAreaView()
        plane.generateRectangleViewDelegate = self
        plane.updateViewMatchedRectangleDelegate = self
        
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
        self.touchedView?.layer.borderWidth = 0
        self.touchedView = nil
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
        guard let touchedView = self.touchedView else {
            return
        }
        guard let newColor = BackgroundColorFactory.generateRandomColor() else {
            return
        }
        
        plane.changeBackGroundColorOfRectangle(id: touchedView.id, to: newColor)
        touchedView.backgroundColor = Converter.convertToUIColor(backgroundColor: newColor)
        let previousBackgroundButtonAlpha = backgroundColorButton.backgroundColor?.cgColor.alpha ?? 1.0
        let convertedOpacityLevel = Int(previousBackgroundButtonAlpha * 10)
        guard let convertedAlpha = Alpha(opacityLevel: convertedOpacityLevel) else {
            return
        }
        updateBackgroundButton(color: newColor, alpha: convertedAlpha)
    }
    
    @IBAction func alphaSliderValueChanged(_ sender: UISlider) {
        let newAlphaValue = Double(String(format: "%.1f", sender.value)) ?? 0
        guard let touchedView = touchedView else {
            return
        }
        plane.changeAlphaValueOfRectangle(id: touchedView.id, to: newAlphaValue)
        
        touchedView.alpha = CGFloat(newAlphaValue)
        updateStatusViewElement(with: touchedView.alpha)
        
    }
    
    @IBAction func minusAlphaValueButtonTouched(_ sender: UIButton) {
        guard let touchedView = touchedView else {
            return
        }
        
        let newAlphaValue = Double(String(format: "%.1f",touchedView.alpha - 0.1)) ?? 0.1
        minusAlphaValueButton.isEnabled = true
        minusAlphaValueButton.backgroundColor = .white
        
        plane.changeAlphaValueOfRectangle(id: touchedView.id, to: newAlphaValue)
        
        touchedView.alpha = newAlphaValue
        updateStatusViewElement(with: touchedView.alpha)
    }
    @IBAction func plusAlphaValueButtonTouched(_ sender: UIButton) {
        guard let touchedView = touchedView else {
            return
        }
        
        let newAlphaValue = Double(String(format: "%.1f",(touchedView.alpha + 0.1))) ?? 1.0
        plusAlphaValueButton.isEnabled = true
        plusAlphaValueButton.backgroundColor = .white
        
        plane.changeAlphaValueOfRectangle(id: touchedView.id, to: newAlphaValue)
        
        touchedView.alpha = newAlphaValue
        updateStatusViewElement(with: newAlphaValue)
    }
    
    private func updateStatusViewElement(with alpha: Double) {
        updateBackgroundColorButtonAlpha(alpha)
        updateAlphaSlider(alpha: alpha)
        updateMinusAlphaValueButton(with: alpha)
        updatePlusAlphaValueButton(with: alpha)
    }
    
    private func updateBackgroundColorButtonAlpha(_ newAlpha: CGFloat) {
        let previousBackgroundColorButtonColor = backgroundColorButton.backgroundColor ?? UIColor()
        self.backgroundColorButton.backgroundColor = previousBackgroundColorButtonColor.withAlphaComponent(newAlpha)
    }
    
    private func updateMinusAlphaValueButton(with alpha: Double) {
        if Double(String(format: "%.1f", alpha)) ?? 0.1 > 0.1 {
            minusAlphaValueButton.isEnabled = true
            minusAlphaValueButton.backgroundColor = .white
        } else {
            minusAlphaValueButton.isEnabled = false
            minusAlphaValueButton.backgroundColor = .systemGray6
        }
    }
    
    private func updatePlusAlphaValueButton(with alpha: Double) {
        if Double(String(format: "%.1f", alpha)) ?? 0.1 < 1.0 {
            plusAlphaValueButton.isEnabled = true
            plusAlphaValueButton.backgroundColor = .white
        } else {
            plusAlphaValueButton.isEnabled = false
            plusAlphaValueButton.backgroundColor = .systemGray6
        }
    }
    
}

extension ViewController: GenerateRectangleViewDelegate {
    func planeDidAddRectangle(_ rectangle: Rectangle) {
        os_log("\(rectangle)")
        
        let newRectangleView = ViewFactory.generateRectangleView(of: rectangle)
        self.drawableAreaView.addSubview(newRectangleView)
    }
}

extension ViewController: UpdateViewMatchedRectangleDelegate {
    func rectangleDidSpecified(_ specifiedRectangle: Rectangle) {
        for rectangleView in drawableAreaView.subviews {
            let rectangleView = rectangleView as? RectangleView
            if rectangleView?.id == specifiedRectangle.id {
                self.touchedView = rectangleView
                break
            }
        }
        
        if let specifiedRectangleView = self.touchedView {
            updateSelectedView(specifiedRectangleView)
            updateBackgroundButton(color: specifiedRectangle.backgroundColor, alpha: specifiedRectangle.alpha)
            updateAlphaSlider(alpha: specifiedRectangleView.alpha)
            updateMinusAlphaValueButton(with: specifiedRectangleView.alpha)
            updatePlusAlphaValueButton(with: specifiedRectangleView.alpha)
        }
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
        let buttonBackgroundColor = Converter.convertToUIColor(backgroundColor: color, alpha: alpha.value)
        backgroundColorButton.backgroundColor = buttonBackgroundColor
    }
    
    private func updateAlphaSlider(alpha: Double) {
        alphaSlider.isEnabled = true
        alphaSlider.setValue(Float(alpha), animated: true)
    }
}

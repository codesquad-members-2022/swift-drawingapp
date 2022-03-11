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
    private var rectangleAndViewMap = [AnyHashable: RectangleViewable]()
    private let notificationCenter = NotificationCenter.default
    private var selectedView: RectangleView?
    weak var generateRectangleButton: UIButton!
    weak var drawableAreaView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var minusAlphaValueButton: UIButton!
    @IBOutlet weak var plusAlphaValueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationCenter()
        
        backgroundColorButton.setTitle("배경색 버튼", for: .disabled)
        
        addGenerateRectangleButton()
        addDrawableAreaView()
        
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
        let touchedLocation = sender.location(in: drawableAreaView)
        let touchedPoint = Point(x: touchedLocation.x, y: touchedLocation.y)
        
        plane.specifyRectangle(point: touchedPoint)
    }
    
    private func initializeViewsInTouchedEmptySpaceCondition() {
        self.selectedView?.layer.borderWidth = 0
        self.selectedView = nil
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
        let newRandomColor = BackgroundColor.random()
        plane.changeBackgroundColor(to: newRandomColor)
    }
    
    @IBAction func alphaSliderValueChanged(_ sender: UISlider) {
        let newAlphaValue = round(sender.value * 10) / 10
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: newAlphaValue) else {return}
        let newAlpha = Alpha(opacityLevel: convertedOpacityLevel)
        
        plane.changeAlphaValue(to: newAlpha)
    }
    
    @IBAction func minusAlphaValueButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.selectedView else {return}
        let previousAlphaValue = Float(selectedView.alpha)
        let newAlphaValue = previousAlphaValue - 0.1
        let normalizedNewAlphaValue = round(newAlphaValue * 10) / 10
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: normalizedNewAlphaValue) else {return}
        plane.changeAlphaValue(to: Alpha(opacityLevel: convertedOpacityLevel))
    }
    @IBAction func plusAlphaValueButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.selectedView else {return}
        let previousAlphaValue = Float(selectedView.alpha)
        let newAlphaValue = previousAlphaValue + 0.1
        let normalizedNewAlphaValue = round(newAlphaValue * 10) / 10
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: normalizedNewAlphaValue) else {return}
        plane.changeAlphaValue(to: Alpha(opacityLevel: convertedOpacityLevel))
    }
    
    func setNotificationCenter() {
        notificationCenter.addObserver(self, selector: #selector(planeDidAddRectangle(_:)), name: Plane.NotificationNames.didAddRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(planeDidSpecifyRectangle(_:)), name: Plane.NotificationNames.didSpecifyRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(planeDidChangeRectangleBackgroundColor(_:)), name: Plane.NotificationNames.didChangeRectangleBackgroundColor, object: plane)
        notificationCenter.addObserver(self, selector: #selector(planeDidChangeRectangleAlpha(_:)), name: Plane.NotificationNames.didChangeRectangleAlpha, object: plane)
    }
}

extension ViewController {
    
    @objc func planeDidAddRectangle(_ notification: Notification) {
        guard let addedRectangle = notification.userInfo?[Plane.UserIDKeys.addedRectangle] as? Rectangle else {return}
        os_log("\(addedRectangle)")
        
        guard let newRectangleView = ViewFactory.makeRectangleView(of: addedRectangle) as? RectangleView else {return}
        self.drawableAreaView.addSubview(newRectangleView)
        rectangleAndViewMap[addedRectangle] = newRectangleView
    }
    
    @objc func planeDidSpecifyRectangle(_ notification: Notification) {
        guard let specifiedRectangle = notification.userInfo?[Plane.UserIDKeys.specifiedRectangle] as? Rectangle,
              let matchedView = rectangleAndViewMap[specifiedRectangle],
              let matchedView = matchedView as? RectangleView else {
                  initializeViewsInTouchedEmptySpaceCondition()
                  return
              }
        
        updateSelectedView(matchedView)
        updateBackgroundButton(color: specifiedRectangle.backgroundColor, alpha: specifiedRectangle.alpha)
        updateAlphaSlider(alpha: Float(matchedView.alpha))
        updateMinusAlphaValueButton(with: Float(matchedView.alpha))
        updatePlusAlphaValueButton(with: Float(matchedView.alpha))
    }
    
    @objc func planeDidChangeRectangleBackgroundColor(_ notification: Notification) {
        guard let backgroundColorChangedRectangle = notification.userInfo?[Plane.UserIDKeys.changedRectangle] as? Rectangle,
              let matchedView = rectangleAndViewMap[backgroundColorChangedRectangle] else {
                  return
              }
        
        let newBackgroundColor = backgroundColorChangedRectangle.backgroundColor
        matchedView.changeBackgroundColor(to: newBackgroundColor.convertToUIColor())
        let previousAlpha = backgroundColorChangedRectangle.alpha
        updateBackgroundButton(color: newBackgroundColor, alpha: previousAlpha)
    }
    
    @objc func planeDidChangeRectangleAlpha(_ notification: Notification) {
        guard let alphaChangedRectangle = notification.userInfo?[Plane.UserIDKeys.changedRectangle] as? Rectangle,
              let matchedView = rectangleAndViewMap[alphaChangedRectangle] else {
                  return
              }
        
        let newAlphaValue = alphaChangedRectangle.alpha.value
        matchedView.changeAlphaValue(to: CGFloat(newAlphaValue))
        updateStatusViewElement(with: newAlphaValue)
    }
    
    private func updateSelectedView(_ selectedView: RectangleView) {
        self.selectedView?.layer.borderWidth = 0
        
        self.selectedView = selectedView
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
        alphaSlider.setValue(alpha, animated: true)
    }
}

extension BackgroundColor {
    fileprivate func convertToUIColor(with alphaValue: Float = 1.0) -> UIColor {
        let convertedRed = Double(self.r) / 255.0
        let convertedGreen = Double(self.g) / 255.0
        let convertedBlue = Double(self.b) / 255.0
        
        return UIColor(red: convertedRed, green: convertedGreen, blue: convertedBlue, alpha: CGFloat(alphaValue))
    }
}

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
    weak var generateRectangleButton: UIButton!
    weak var generateImageRectangleButton: UIButton!
    weak var drawableAreaView: DrawableAreaView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var minusAlphaValueButton: UIButton!
    @IBOutlet weak var plusAlphaValueButton: UIButton!
    @IBOutlet weak var xPointLabel: UILabel!
    @IBOutlet weak var plusXPointButton: UIButton!
    @IBOutlet weak var minusXPointButton: UIButton!
    @IBOutlet weak var yPointLabel: UILabel!
    @IBOutlet weak var plusYPointButton: UIButton!
    @IBOutlet weak var minusYPointButton: UIButton!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var plusWidthButton: UIButton!
    @IBOutlet weak var minusWidthButton: UIButton!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var plusHeightButton: UIButton!
    @IBOutlet weak var minusHeightButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationCenter()
        
        addDrawableAreaView()
        addGenerateRectangleButton()
        addGenerateImageRectangleButton()
        
        setStatusViewElements()
        
        initializeViewsInTouchedEmptySpaceCondition()
        
        self.drawableAreaView.delegate = self
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
        let spacing = 0.5
        let buttonX = (self.drawableAreaView.frame.size.width/2.0) - (buttonWidth + spacing)
        let buttonY = self.view.frame.size.height - buttonHeight
        let buttonImageConfiguration = UIImage.SymbolConfiguration.init(hierarchicalColor: .black)
        let buttonImage = UIImage(systemName: "rectangle", withConfiguration: buttonImageConfiguration)
        generateButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        generateButton.backgroundColor = .systemGray6
        generateButton.setImage(buttonImage, for: .normal)
        generateButton.layer.cornerRadius = 15
        
        self.generateRectangleButton = generateButton
        self.view.addSubview(generateButton)
    }
    
    func addGenerateImageRectangleButton() {
        let buttonUIAction = UIAction { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true)
        }
        let generateButton = UIButton(type: .custom, primaryAction: buttonUIAction)
        let buttonWidth = 100.0
        let buttonHeight = 100.0
        let spacing = 0.5
        let buttonX = (self.drawableAreaView.frame.size.width/2.0) + spacing
        let buttonY = self.view.frame.size.height - buttonHeight
        let buttonImageConfiguration = UIImage.SymbolConfiguration.init(hierarchicalColor: .black)
        let buttonImage = UIImage(systemName: "photo", withConfiguration: buttonImageConfiguration)
        generateButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        generateButton.backgroundColor = .systemGray6
        generateButton.setImage(buttonImage, for: .normal)
        generateButton.layer.cornerRadius = 15
        
        self.generateRectangleButton = generateButton
        self.view.addSubview(generateButton)
    }
    
    func addDrawableAreaView() {
        let drawableAreaViewX = self.view.frame.origin.x
        let drawableAreaViewY = self.view.frame.origin.y
        let drawableAreaViewWidth = self.view.frame.width - self.statusView.frame.width
        let generateButtonsHeight = 100.0
        let drawableAreaViewHeight = self.view.frame.height - generateButtonsHeight
        
        let newDrawableAreaView = DrawableAreaView.init(frame: CGRect(x: drawableAreaViewX, y: drawableAreaViewY, width: drawableAreaViewWidth, height: drawableAreaViewHeight))
        
        self.drawableAreaView = newDrawableAreaView
        self.view.addSubview(newDrawableAreaView)
    }
    
    private func initializeViewsInTouchedEmptySpaceCondition() {

        self.drawableAreaView.showSelectedView(nil)
        backgroundColorButton.isEnabled = false
        backgroundColorButton.setTitle("배경색 변경 불가", for: .disabled)
        backgroundColorButton.backgroundColor = .clear
        alphaSlider.isEnabled = false
        let alphaSliderCenterValue = (alphaSlider.minimumValue + alphaSlider.maximumValue) / 2
        alphaSlider.setValue(alphaSliderCenterValue, animated: true)
        minusAlphaValueButton.isEnabled = false
        minusAlphaValueButton.backgroundColor = .systemGray6
        plusAlphaValueButton.isEnabled = false
        plusAlphaValueButton.backgroundColor = .systemGray6
        updateXPointLabel(with: nil)
        updateYPointLabel(with: nil)
        updateWidthLabel(with: nil)
        updateHeightLabel(with: nil)
    }
    
    func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidAddRectangle(_:)), name: Plane.NotificationNames.didAddRectangle, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidSpecifyRectangle(_:)), name: Plane.NotificationNames.didSpecifyRectangle, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidChangeRectangleBackgroundColor(_:)), name: Plane.NotificationNames.didChangeRectangleBackgroundColor, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidChangeRectangleAlpha(_:)), name: Plane.NotificationNames.didChangeRectangleAlpha, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidAddPhoto(_:)), name: Plane.NotificationNames.didAddPhoto, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidChangeRectanglePoint), name: Plane.NotificationNames.didChangeRectanglePoint, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidChangeRectangleSize(_:)), name: Plane.NotificationNames.didChangeRectangleSize, object: plane)
    }
}

extension ViewController {
    
    @objc func planeDidAddRectangle(_ notification: Notification) {
        guard let addedRectangle = notification.userInfo?[Plane.UserInfoKeys.addedRectangle] as? Rectangle else {return}
        os_log("\(addedRectangle)")
        
        let newRectangleView = ViewFactory.makeRectangleView(of: addedRectangle)
        self.drawableAreaView.addSubview(newRectangleView)
        rectangleAndViewMap[addedRectangle] = newRectangleView
    }
    
    @objc func planeDidAddPhoto(_ notification: Notification) {
        guard let addedPhoto = notification.userInfo?[Plane.UserInfoKeys.addedPhoto] as? Photo else {return}
        os_log("\(addedPhoto)")
        
        let newPhotoView = ViewFactory.makePhotoView(of: addedPhoto)
        self.drawableAreaView.addSubview(newPhotoView)
        rectangleAndViewMap[addedPhoto] = newPhotoView
    }
    
    @objc func planeDidSpecifyRectangle(_ notification: Notification) {
        guard let specifiedRectangle = notification.userInfo?[Plane.UserInfoKeys.specifiedRectangle] as? BasicShape,
              let matchedView = rectangleAndViewMap[specifiedRectangle] else {
                  initializeViewsInTouchedEmptySpaceCondition()
                  return
              }
        
        self.drawableAreaView.showSelectedView(matchedView)
        updateBackgroundColorButton(with: specifiedRectangle)
        updateAlphaSlider(alpha: specifiedRectangle.alpha.value)
        updateMinusAlphaValueButton(with: specifiedRectangle.alpha.value)
        updatePlusAlphaValueButton(with: specifiedRectangle.alpha.value)
        updateXPointLabel(with: specifiedRectangle.point.x)
        updateYPointLabel(with: specifiedRectangle.point.y)
        updateWidthLabel(with: specifiedRectangle.size.width)
        updateHeightLabel(with: specifiedRectangle.size.height)
    }
    
    @objc func planeDidChangeRectangleBackgroundColor(_ notification: Notification) {
        guard let backgroundColorChangedRectangle = notification.userInfo?[Plane.UserInfoKeys.changedRectangle] as? BasicShape  else {
                  return
              }
        if let backgroundColorChangedRectangle = backgroundColorChangedRectangle as? BackgroundColorChangable {
            let newBackgroundColor = backgroundColorChangedRectangle.backgroundColor
            self.drawableAreaView.updateSelectedView(backgroundColor: newBackgroundColor.convertToUIColor())
        }
        let previousAlpha = backgroundColorChangedRectangle.alpha
        updateBackgroundColorButton(with: backgroundColorChangedRectangle)
    }
    
    @objc func planeDidChangeRectangleAlpha(_ notification: Notification) {
        guard let alphaChangedRectangle = notification.userInfo?[Plane.UserInfoKeys.changedRectangle] as? BasicShape else {
                  return
              }
        
        let newAlphaValue = alphaChangedRectangle.alpha.value
        self.drawableAreaView.updateSelectedView(alpha: CGFloat(newAlphaValue))
        updateStatusViewElement(with: newAlphaValue)
    }
    
    @objc func planeDidChangeRectanglePoint(_ notification: Notification) {
        guard let movedRectangle = notification.userInfo?[Plane.UserInfoKeys.changedRectangle] as? BasicShape else {
                  return
              }
        
        let newPoint = movedRectangle.point
        let convertedNewPoint = CGPoint(x: newPoint.x, y: newPoint.y)
        
        self.drawableAreaView.updateSelectedView(point: convertedNewPoint)
        updateXPointLabel(with: newPoint.x)
        updateYPointLabel(with: newPoint.y)
        updatePointButtons(with: newPoint)
    }
    
    @objc func planeDidChangeRectangleSize(_ notification: Notification) {
        guard let sizeChangedRectangle = notification.userInfo?[Plane.UserInfoKeys.changedRectangle] as? BasicShape else {
                  return
              }
        
        let newSize = sizeChangedRectangle.size
        let newWidth = newSize.width
        let newHeight = newSize.height
        
        self.drawableAreaView.updateSelectedView(width: newWidth, height: newHeight)
        updateWidthLabel(with: newWidth)
        updateHeightLabel(with: newHeight)
        updateSizeButtons(with: newSize)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pointLimit = (Double(self.drawableAreaView.frame.width),
                          Double(self.drawableAreaView.frame.height))
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            guard let image = image.pngData() else {return}
            self.plane.addNewPhoto(in: pointLimit, with: image)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let image = image.pngData() else {return}
            self.plane.addNewPhoto(in: pointLimit, with: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: DrawableAreaViewDelegate {
    func drawableAreaViewDidReceiveTap(_ drawableAreaView: DrawableAreaView) {
        guard let touchedPoint = drawableAreaView.touchedPoint else {return}
        plane.specifyRectangle(point: touchedPoint)
    }
    
    func drawableAreaViewDidBeginPan(_ drawableAreaView: DrawableAreaView) {
        guard let touchedPoint = drawableAreaView.touchedPoint else {return}
        plane.specifyRectangle(point: touchedPoint)
        self.drawableAreaView.makeTemporaryView()
    }
    
    func drawableAreaViewDidChangePan(_ drawableAreaView: DrawableAreaView) { // 출력하는 메서드(나머지는 입력을 받고 plane에 지시하는 메서드)
        guard let dummyView = drawableAreaView.movingTemporaryView else {return}
        let newPoint = dummyView.frame.origin
        updateXPointLabel(with: newPoint.x)
        updateYPointLabel(with: newPoint.y)
    }
    
    func drawableAreaViewDidEndPan(_ drawableAreaView: DrawableAreaView) {
        guard let dummyView = drawableAreaView.movingTemporaryView else {return}
        let newPoint = dummyView.frame.origin
        let convertedNewPoint = Point(x: newPoint.x, y: newPoint.y)
        plane.changePointOfSpecifiedRectangle(to: convertedNewPoint)
    }
}

extension ViewController {
    
    private func setStatusViewElements() {
        let labels = [xPointLabel, yPointLabel, widthLabel, heightLabel]
        labels.forEach { label in
            label?.layer.cornerRadius = 9
            label?.layer.borderWidth = 0.5
            label?.layer.borderColor = UIColor.systemGray2.cgColor
        }
    }
    
    @IBAction func backgroundButtonTouched(_ sender: UIButton) {
        let newRandomColor = BackgroundColor.random()
        plane.changeBackgroundColorOfSpecifiedRectangle(to: newRandomColor)
    }
    
    @IBAction func alphaSliderValueChanged(_ sender: UISlider) {
        let newAlphaValue = sender.value.normalized()
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: newAlphaValue) else {return}
        let newAlpha = Alpha(opacityLevel: convertedOpacityLevel)
        
        plane.changeAlphaValueOfSpecifiedRectangle(to: newAlpha)
    }
    
    @IBAction func minusAlphaValueButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let previousAlphaValue = Float(selectedView.alpha)
        let newAlphaValue = previousAlphaValue - 0.1
        let normalizedNewAlphaValue = newAlphaValue.normalized()
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: normalizedNewAlphaValue) else {return}
        plane.changeAlphaValueOfSpecifiedRectangle(to: Alpha(opacityLevel: convertedOpacityLevel))
    }
    
    @IBAction func plusAlphaValueButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let previousAlphaValue = Float(selectedView.alpha)
        let newAlphaValue = previousAlphaValue + 0.1
        let normalizedNewAlphaValue = newAlphaValue.normalized()
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: normalizedNewAlphaValue) else {return}
        plane.changeAlphaValueOfSpecifiedRectangle(to: Alpha(opacityLevel: convertedOpacityLevel))
    }
    
    @IBAction func plusXPointButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let previousPoint = selectedView.frame.origin
        let newXPoint = previousPoint.x + 10
        let newPoint = Point(x: newXPoint, y: previousPoint.y)
        
        plane.changePointOfSpecifiedRectangle(to: newPoint)
    }
    
    @IBAction func minusXPointButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let previousPoint = selectedView.frame.origin
        let newXPoint = previousPoint.x > 11 ? previousPoint.x - 10 : 1
        let newPoint = Point(x: newXPoint, y: previousPoint.y)
        
        plane.changePointOfSpecifiedRectangle(to: newPoint)
    }
    
    @IBAction func plusYPointButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let previousPoint = selectedView.frame.origin
        let newYPoint = previousPoint.y + 10
        let newPoint = Point(x: previousPoint.x, y: newYPoint)
        
        plane.changePointOfSpecifiedRectangle(to: newPoint)
    }
    
    @IBAction func minusYPointButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let previousPoint = selectedView.frame.origin
        let newYPoint = previousPoint.y > 11 ? previousPoint.y - 10 : 1
        let newPoint = Point(x: previousPoint.x, y: newYPoint)
        
        plane.changePointOfSpecifiedRectangle(to: newPoint)
    }
    
    @IBAction func plusWidthButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let newWidth = selectedView.frame.width + 10
        let previousHeight = selectedView.frame.height
        let newSize = Size(width: newWidth, height: previousHeight)
        
        plane.changeSizeOfSpecifiedRectangle(to: newSize)
    }
    
    @IBAction func minusWidthButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let newWidth = selectedView.frame.width > 11 ? selectedView.frame.width - 10 : 1
        let previousHeight = selectedView.frame.height
        let newSize = Size(width: newWidth, height: previousHeight)
        
        plane.changeSizeOfSpecifiedRectangle(to: newSize)
    }
    
    @IBAction func plusHeightButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let previousWidth = selectedView.frame.width
        let newHeight = selectedView.frame.height + 10
        let newSize = Size(width: previousWidth, height: newHeight)
        
        plane.changeSizeOfSpecifiedRectangle(to: newSize)
    }
    
    @IBAction func minusHeightButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.drawableAreaView.selectedView else {return}
        let previousWidth = selectedView.frame.size.width
        let newHeight = selectedView.frame.size.height > 11 ? selectedView.frame.size.height - 10 : 1
        let newSize = Size(width: previousWidth, height: newHeight)
        
        plane.changeSizeOfSpecifiedRectangle(to: newSize)
    }
    
    private func updateBackgroundColorButton(with rectangle: BasicShape) {
        guard let rectangle = rectangle as? BackgroundColorChangable & BasicShape else {
            backgroundColorButton.isEnabled = false
            backgroundColorButton.backgroundColor = .clear
            return
        }
        backgroundColorButton.isEnabled = true
        let currentAlphaValue = rectangle.alpha.value
        backgroundColorButton.setTitle(rectangle.backgroundColor.hexCode, for: .normal)
        let buttonBackgroundColor = rectangle.backgroundColor.convertToUIColor(with: currentAlphaValue)
        backgroundColorButton.backgroundColor = buttonBackgroundColor
    }
    
    private func updateStatusViewElement(with alpha: Float) {
        updateBackgroundColorButtonAlpha(with: CGFloat(alpha))
        updateAlphaSlider(alpha: alpha)
        updateMinusAlphaValueButton(with: alpha)
        updatePlusAlphaValueButton(with: alpha)
    }
    
    private func updateBackgroundColorButtonAlpha(with newAlpha: CGFloat) {
        if self.backgroundColorButton.isEnabled == true {
            let previousBackgroundColorButtonColor = backgroundColorButton.backgroundColor ?? UIColor()
            self.backgroundColorButton.backgroundColor = previousBackgroundColorButtonColor.withAlphaComponent(newAlpha)
        }
    }
    
    private func updateMinusAlphaValueButton(with alpha: Float) {
        if alpha.normalized() > 0.1 {
            minusAlphaValueButton.isEnabled = true
            minusAlphaValueButton.backgroundColor = .white
        } else {
            minusAlphaValueButton.isEnabled = false
            minusAlphaValueButton.backgroundColor = .systemGray6
        }
    }
    
    private func updatePlusAlphaValueButton(with alpha: Float) {
        if alpha.normalized() < 1.0 {
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
    
    private func updateXPointLabel(with xPoint: Double?) {
        let defaultText = " X: "
        guard let xPoint = xPoint else {
            return xPointLabel.text = defaultText
        }
        
        let updatedText = String(format: "%.4f", xPoint)
        xPointLabel.text = defaultText + updatedText
    }
    
    private func updateYPointLabel(with yPoint: Double?) {
        let defaultText = " Y: "
        guard let yPoint = yPoint else {
            return yPointLabel.text = defaultText
        }

        let updatedText = String(format: "%.4f", yPoint)
        yPointLabel.text = defaultText + updatedText
    }
    
    private func updateWidthLabel(with width: Double?) {
        let defaultText = " W: "
        guard let width = width else {
            return widthLabel.text = defaultText
        }
        
        let updatedText = String(format: "%.4f", width)
        widthLabel.text = defaultText + updatedText
    }
    
    private func updateHeightLabel(with height: Double?) {
        let defaultText = " H: "
        guard let height = height else {
            return heightLabel.text = defaultText
        }
        
        let updatedText = String(format: "%.4f", height)
        heightLabel.text = defaultText + updatedText
    }
    
    private func updatePointButtons(with point: Point) {
        if point.x <= 1 {
            minusXPointButton.isEnabled = false
        } else {
            minusXPointButton.isEnabled = true
        }
        
        if point.y <= 1 {
            minusYPointButton.isEnabled = false
        } else {
            minusYPointButton.isEnabled = true
        }
    }
    
    private func updateSizeButtons(with size: Size) {
        if size.width <= 1 {
            minusWidthButton.isEnabled = false
        } else {
            minusWidthButton.isEnabled = true
        }
        
        if size.height <= 1 {
            minusHeightButton.isEnabled = false
        } else {
            minusHeightButton.isEnabled = true
        }
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

extension Float {
    fileprivate func normalized() -> Float {
        return roundf(self * 10) / 10
    }
}

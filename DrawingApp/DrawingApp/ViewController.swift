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
    private var selectedView: RectangleViewable?
    private var movingTemporaryView: RectangleViewable?
    weak var generateRectangleButton: UIButton!
    weak var generateImageRectangleButton: UIButton!
    weak var drawableAreaView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var minusAlphaValueButton: UIButton!
    @IBOutlet weak var plusAlphaValueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationCenter()
        
        addDrawableAreaView()
        addGenerateRectangleButton()
        addGenerateImageRectangleButton()
        
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        drawableAreaView.addGestureRecognizer(panGesture)
        panGesture.minimumNumberOfTouches = 2
        panGesture.maximumNumberOfTouches = 2
        
        self.view.addSubview(drawableAreaView)
    }
    
    @objc func viewDidTouched(sender: UITapGestureRecognizer) {
        let touchedLocation = sender.location(in: drawableAreaView)
        let touchedPoint = Point(x: touchedLocation.x, y: touchedLocation.y)
        
        plane.specifyRectangle(point: touchedPoint)
    }
    
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: drawableAreaView)
        
        switch sender.state {
            case .began:
                let touchedLocation = sender.location(in: drawableAreaView)
                let touchedPoint = Point(x: touchedLocation.x, y: touchedLocation.y)
                plane.specifyRectangle(point: touchedPoint)
                makeTemporaryView()
            case .changed:
                guard let movingTemporaryView = self.movingTemporaryView else { return }
                movingTemporaryView.move(distance: translation)
                sender.setTranslation(.zero, in: drawableAreaView)
            case .ended:
                guard let movingTemporaryView = self.movingTemporaryView as? UIView,
                      let selectedView = self.selectedView,
                      let specifiedRectangle = plane.specifiedRectangle else {
                    return
                }
                
                selectedView.move(to: movingTemporaryView.center)
                let convertedNewPoint = Point(x: movingTemporaryView.frame.origin.x,
                                           y:movingTemporaryView.frame.origin.y)
                specifiedRectangle.move(to: convertedNewPoint)
                self.movingTemporaryView = nil
            @unknown default:
                return
        }
    }
    
    private func makeTemporaryView() {
        guard let selectedView = self.selectedView else { return }
        
        let copiedView = selectedView.copyToNewInstance()
        copiedView.alpha = 0.5
        self.movingTemporaryView = copiedView
        
        self.drawableAreaView.addSubview(copiedView)
    }
    
    private func initializeViewsInTouchedEmptySpaceCondition() {
        self.selectedView?.layer.borderWidth = 0
        self.selectedView = nil
        backgroundColorButton.isHidden = true
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
        let newAlphaValue = sender.value.normalized()
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: newAlphaValue) else {return}
        let newAlpha = Alpha(opacityLevel: convertedOpacityLevel)
        
        plane.changeAlphaValue(to: newAlpha)
    }
    
    @IBAction func minusAlphaValueButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.selectedView else {return}
        let previousAlphaValue = Float(selectedView.alpha)
        let newAlphaValue = previousAlphaValue - 0.1
        let normalizedNewAlphaValue = newAlphaValue.normalized()
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: normalizedNewAlphaValue) else {return}
        plane.changeAlphaValue(to: Alpha(opacityLevel: convertedOpacityLevel))
    }
    @IBAction func plusAlphaValueButtonTouched(_ sender: UIButton) {
        guard let selectedView = self.selectedView else {return}
        let previousAlphaValue = Float(selectedView.alpha)
        let newAlphaValue = previousAlphaValue + 0.1
        let normalizedNewAlphaValue = newAlphaValue.normalized()
        guard let convertedOpacityLevel = Alpha.OpacityLevel(rawValue: normalizedNewAlphaValue) else {return}
        plane.changeAlphaValue(to: Alpha(opacityLevel: convertedOpacityLevel))
    }
    
    func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidAddRectangle(_:)), name: Plane.NotificationNames.didAddRectangle, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidSpecifyRectangle(_:)), name: Plane.NotificationNames.didSpecifyRectangle, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidChangeRectangleBackgroundColor(_:)), name: Plane.NotificationNames.didChangeRectangleBackgroundColor, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidChangeRectangleAlpha(_:)), name: Plane.NotificationNames.didChangeRectangleAlpha, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidAddPhoto(_:)), name: Plane.NotificationNames.didAddPhoto, object: plane)
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
        guard let specifiedRectangle = notification.userInfo?[Plane.UserInfoKeys.specifiedRectangle] as? AnyRectangularable,
              let matchedView = rectangleAndViewMap[specifiedRectangle] else {
                  initializeViewsInTouchedEmptySpaceCondition()
                  return
              }
        
        updateSelectedView(matchedView)
        updateBackgroundColorButton(with: specifiedRectangle)
        updateAlphaSlider(alpha: Float(matchedView.alpha))
        updateMinusAlphaValueButton(with: Float(matchedView.alpha))
        updatePlusAlphaValueButton(with: Float(matchedView.alpha))
    }
    
    @objc func planeDidChangeRectangleBackgroundColor(_ notification: Notification) {
        guard let backgroundColorChangedRectangle = notification.userInfo?[Plane.UserInfoKeys.changedRectangle] as? AnyRectangularable,
              let matchedView = rectangleAndViewMap[backgroundColorChangedRectangle] else {
                  return
              }
        if let backgroundColorChangedRectangle = backgroundColorChangedRectangle as? BackgroundColorChangable {
            let newBackgroundColor = backgroundColorChangedRectangle.backgroundColor
            matchedView.changeBackgroundColor(to: newBackgroundColor.convertToUIColor())
        }
        let previousAlpha = backgroundColorChangedRectangle.alpha
        updateBackgroundColorButton(with: backgroundColorChangedRectangle)
    }
    
    @objc func planeDidChangeRectangleAlpha(_ notification: Notification) {
        guard let alphaChangedRectangle = notification.userInfo?[Plane.UserInfoKeys.changedRectangle] as? AnyRectangularable,
              let matchedView = rectangleAndViewMap[alphaChangedRectangle] else {
                  return
              }
        
        let newAlphaValue = alphaChangedRectangle.alpha.value
        matchedView.changeAlphaValue(to: CGFloat(newAlphaValue))
        updateStatusViewElement(with: newAlphaValue)
    }
    
    private func updateSelectedView(_ selectedView: RectangleViewable) {
        self.selectedView?.layer.borderWidth = 0
        
        self.selectedView = selectedView
        selectedView.layer.borderWidth = 3
        selectedView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func updateBackgroundColorButton(with rectangle: AnyRectangularable) {
        backgroundColorButton.isHidden = !(rectangle is BackgroundColorChangable)
        let currentAlphaValue = rectangle.alpha.value
        
        guard let rectangle = rectangle as? BackgroundColorChangable else {return}
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
        let previousBackgroundColorButtonColor = backgroundColorButton.backgroundColor ?? UIColor()
        self.backgroundColorButton.backgroundColor = previousBackgroundColorButtonColor.withAlphaComponent(newAlpha)
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

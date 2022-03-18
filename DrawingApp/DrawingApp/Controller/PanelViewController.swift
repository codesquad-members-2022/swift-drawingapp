//
//  PanelViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import UIKit

protocol LayerPropertyContollable {
    func setSizeStepperHandler(handler: ((Size) -> ())?)
    func setOriginStepperHandler(handler:  ((Point) -> ())?)
    func setSliderHandler(handler: ((Float) -> ())?)
    func setColorButtonHandler(handler: ((Color) -> ())?)
    func setTextFieldHandler(handler: ((String) -> ())?)
}

class PanelViewController: UIViewController {
    
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var AlphaLabel: UILabel!
    @IBOutlet weak var alphaSlider: UISlider!
    
    @IBOutlet weak var xOriginLabel: UILabel!
    @IBOutlet weak var yOriginLabel: UILabel!
    
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var isSizeFixedRatio: UISwitch!
    
    @IBOutlet weak var yOriginStepper: UIStepper!
    @IBOutlet weak var xOriginStepper: UIStepper!
    
    @IBOutlet weak var widthStepper: UIStepper!
    @IBOutlet weak var heightStpper: UIStepper!
    
    private var aspectRatio: Double?
   
    @IBOutlet weak var textField: UITextField!
    
    enum Event {
        static let didChangeSlider = Notification.Name("sliderChanged")
        static let didTouchColorButton = Notification.Name("didTouchColorButton")
        static let didTouchOriginStepper = Notification.Name("didTouchOriginStepper")
        static let didTouchSizeStepper = Notification.Name("didTouchSizeStepper")
        static let didEditTextField = Notification.Name("didEditTextField")
    }
    
    enum InfoKey {
        static let value = "value"
        static let origin = "origin"
        static let size = "size"
        static let text = "text"
    }
    
    var didTouchSizeStepper: ((Size) -> ())?
    var didTouchOriginStepper: ((Point) -> ())?
    var didChangeSlider: ((Float) -> ())?
    var didTouchColorButton: ((Color) -> ())?
    var didEditTextField: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribePlaneNotification()
        
        if let secondaryVC = splitViewController?.viewController(for: .secondary) {
            setHandler(to: secondaryVC)
        }
        
        addTargetAction(to: textField)
    }
    
    private func addTargetAction(to textField: UIControl) {
        textField.addTarget(self, action: #selector(didEditTextField(_:)), for: .editingChanged)
    }
    
    private func setHandler(to viewController: UIViewController) {
        if let viewController = viewController as? LayerViewDraggable {
            
            viewController.setDragHandler { [weak self] temporaryView in
                let temporaryOrigin = Point(x: temporaryView.frame.origin.x, y: temporaryView.frame.origin.y)
                self?.displayTemporaryOrigin(temporaryOrigin)
            }
        }
    }
    
    private func subscribePlaneNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectLayer(_:)), name: Plane.Event.didSelectLayer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeColor(_:)), name: Plane.Event.didChangeColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeAlpha(_:)), name: Plane.Event.didChangeAlpha, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSize(_:)), name: Plane.Event.didChangeSize, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrigin(_:)), name: Plane.Event.didChangeOrigin, object: nil)
    }
}

extension PanelViewController: LayerPropertyContollable {
    func setSizeStepperHandler(handler: ((Size) -> ())?) {
        self.didTouchSizeStepper = handler
    }
    func setOriginStepperHandler(handler:  ((Point) -> ())?) {
        self.didTouchOriginStepper = handler
    }
    func setSliderHandler(handler: ((Float) -> ())?) {
        self.didChangeSlider = handler
    }
    func setColorButtonHandler(handler: ((Color) -> ())?) {
        self.didTouchColorButton = handler
    }
    func setTextFieldHandler(handler: ((String) -> ())?) {
        self.didEditTextField = handler
    }
}

// MARK: - Use case: Display properties of selected view

extension PanelViewController {
    @objc func didSelectLayer(_ notification: Notification) {
        guard let selected = notification.userInfo?[Plane.InfoKey.selected] as? Layer else {
            // Clear all panel when nothing selected
            clearPanel()
            return
        }
        
        // Every Layer should display size & origin
        displaySize(selected)
        displayOrigin(selected)
        
        // Display Property & Enable related controls when Layer is mutable
        if let colorMutable = selected as? ColorMutable {
            displayColor(colorMutable)
        } else {
            clearColorButton()
        }
        
        if let alphaMutable = selected as? AlphaMutable {
            displayAlpha(alphaMutable)
        } else {
            clearAlphaSlider()
        }
        
        if let textMutable = selected as? TextMutable {
            displayText(textMutable)
        } else {
            clearTextField()
        }
    }
    
    private func displayColor(_ selected: ColorMutable) {
        colorButton.isEnabled = true
        
        let selectedColor = UIColor(with: selected.color)
        colorButton.tintColor = selectedColor
        
        let selectedColorHex = selectedColor.toHex() ?? ""
        colorButton.setTitle(selectedColorHex, for: .normal)
        
        let visibleColor = selectedColor.isDark ? UIColor.white : UIColor.black
        colorButton.setTitleColor(visibleColor, for: .normal)
    }
    
    private func displayAlpha(_ selected: AlphaMutable) {
        alphaSlider.isEnabled = true
        
        let selectedAlpha = selected.alpha
        alphaSlider.value = selectedAlpha.value * 10
        
        let selectedAlphaString = String(format: "%.0f", selectedAlpha.value * 10)
        AlphaLabel.text = selectedAlphaString
    }
    
    private func displaySize(_ selected: Layer) {
        isSizeFixedRatio.isEnabled = true
        widthStepper.isEnabled = true
        heightStpper.isEnabled = true
        
        let selectedWidth = selected.size.width
        let selectedHeight = selected.size.height
        
        widthStepper.value = selectedWidth
        heightStpper.value = selectedHeight
        
        widthLabel.text = String(format: "%.0f", selectedWidth)
        heightLabel.text = String(format: "%.0f", selectedHeight)
        
        aspectRatio = selected.aspectRatio
    }
    
    private func displayOrigin(_ selected: Layer) {
        xOriginStepper.isEnabled = true
        yOriginStepper.isEnabled = true
        
        let selectedX = selected.origin.x
        let selectedY = selected.origin.y
        
        xOriginStepper.value = selectedX
        yOriginStepper.value = selectedY
        
        xOriginLabel.text = String(format: "%.0f", selectedX)
        yOriginLabel.text = String(format: "%.0f", selectedY)
        
    }
    
    private func displayText(_ selected: TextMutable) {
        textField.isEnabled = true
        textField.text = selected.text
    }
    
    private func clearPanel() {
        clearColorButton()
        clearAlphaSlider()
        clearSizeStepper()
        clearOriginStepper()
    }
    
    private func clearColorButton() {
        colorButton.setTitle("", for: .normal)
        colorButton.tintColor = UIColor.systemGray
        colorButton.isEnabled = false
    }
    
    private func clearAlphaSlider() {
        AlphaLabel.text = ""
        alphaSlider.value = 0
        alphaSlider.isEnabled = false
    }
    
    private func clearSizeStepper() {
        widthLabel.text = ""
        heightLabel.text = ""
        
        widthStepper.isEnabled = false
        heightStpper.isEnabled = false
        isSizeFixedRatio.isEnabled = false
    }
    
    private func clearOriginStepper() {
        xOriginLabel.text = ""
        yOriginLabel.text = ""
        
        xOriginStepper.isEnabled = false
        yOriginStepper.isEnabled = false
    }
    
    private func clearTextField() {
        textField.text = ""
        textField.isEnabled = false
    }
}

// MARK: - Use case: Display origin of temporary view when dragged

extension PanelViewController {
    
    
    private func displayTemporaryOrigin(_ origin: Point) {
        let selectedX = origin.x
        let selectedY = origin.y
        
        xOriginStepper.value = selectedX
        yOriginStepper.value = selectedY
        
        xOriginLabel.text = String(format: "%.0f", selectedX)
        yOriginLabel.text = String(format: "%.0f", selectedY)
    }
}

// MARK: - Use case: Change Color using button

extension PanelViewController {
    
    @IBAction func didTouchColorButton(_ sender: UIButton) {
        let randomColor = Color.random()
        didTouchColorButton?(randomColor)
    }
    
    @objc func didChangeColor(_ notification: Notification) {
        guard let plane = notification.object as? Plane else { return }
        guard let mutated = plane.selected as? ColorMutable else { return }
        displayColor(mutated)
    }
}

// MARK: - Use case: Change Alpha using slider

extension PanelViewController {

    @IBAction func didChangeSlider(_ sender: UISlider) {
        didChangeSlider?(sender.value)
    }
    
    @objc func didChangeAlpha(_ notification: Notification) {
        guard let plane = notification.object as? Plane else { return }
        guard let mutated = plane.selected as? AlphaMutable else { return }
        displayAlpha(mutated)
    }
}

// MARK: - Use case: Change Origin using stepper

extension PanelViewController {

    @IBAction func didTouchOriginStepper(_ sender: UIStepper) {
        let newOrigin = Point(x: xOriginStepper.value, y: yOriginStepper.value)
        didTouchOriginStepper?(newOrigin)
    }
    
    @objc func didChangeOrigin(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.changed] as? Layer else { return }
        displayOrigin(mutated)
    }
    
}

// MARK: - Use case: Change Size using stepper

extension PanelViewController {

    @IBAction func didTouchSizeStepper(_ sender: UIStepper) {
        var newSize = Size(width: 0, height: 0)
        
        if isSizeFixedRatio.isOn, let aspectRatio = aspectRatio {
            newSize = sender === widthStepper ?
            Size(width: widthStepper.value, height: widthStepper.value * aspectRatio) :
            Size(width: heightStpper.value * (1/aspectRatio) , height: heightStpper.value)
        } else {
            newSize = Size(width: widthStepper.value, height: heightStpper.value)
        }
        
        didTouchSizeStepper?(newSize)
    }
    
    @objc func didChangeSize(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.changed] as? Layer else { return }
        displaySize(mutated)
    }
}

// MARK: - Use case: Change Text using textField

extension PanelViewController {
    
    @objc func didEditTextField(_ sender: UITextField) {
        didEditTextField?(textField.text ?? "")
    }
}

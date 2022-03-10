//
//  PanelViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import UIKit

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
    
    @IBAction func originChanged(_ sender: UIStepper) {
        // Canvas로 changed 전송
        let newOrigin = Point(x: xOriginStepper.value, y: yOriginStepper.value)
        NotificationCenter.default.post(name: PanelViewController.event.originStepperChanged, object: self, userInfo: [PanelViewController.InfoKey.newOrigin: newOrigin])
    }
    
    @IBAction func sizeChanged(_ sender: UIStepper) {
        // Canvas로 changed 전송
        var newSize = Size(width: 0, height: 0)
        if isSizeFixedRatio.isOn, let aspectRatio = aspectRatio {
            newSize = sender === widthStepper ?
            Size(width: widthStepper.value, height: widthStepper.value * aspectRatio) :
            Size(width: heightStpper.value * (1/aspectRatio) , height: heightStpper.value)
        } else {
            newSize = Size(width: widthStepper.value, height: heightStpper.value)
        }
        
        NotificationCenter.default.post(name: PanelViewController.event.sizeStpperChanged, object: self, userInfo: [PanelViewController.InfoKey.newSize: newSize])
    }
    
    enum event {
        static let sliderChanged = Notification.Name("sliderChanged")
        static let colorButtonPressed = Notification.Name("colorButtonPressed")
        static let originStepperChanged = Notification.Name("originStepperChanged")
        static let sizeStpperChanged = Notification.Name("sizeStpperChanged")
    }
    
    enum InfoKey {
        static let sliderValue = "value"
        static let newOrigin = "origin"
        static let newSize = "size"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observePlane()
    }
    
    private func observePlane() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectViewModel(_:)), name: Plane.event.selectViewModel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateColor(_:)), name: Plane.event.mutateColorViewModel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateAlpha(_:)), name: Plane.event.mutateAlphaViewModel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateSize(_:)), name: Plane.event.mutateSizeViewModel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateOrigin(_:)), name: Plane.event.mutateOriginViewModel, object: nil)
    }
}

// MARK: - Use case: Display properties of selected view
extension PanelViewController {
    @objc func didSelectViewModel(_ notification: Notification) {

        guard let selected = notification.userInfo?[Plane.InfoKey.new] as? ViewModel else {
            clearColorButton()
            clearAlphaSlider()
            clearSizeStepper()
            clearOriginStepper()
            return
        }
        
        displaySize(selected)
        displayOrigin(selected)
        
        if let colorMutableViewModel = selected as? ColorMutable {
            displayColor(colorMutableViewModel)
        } else {
            clearColorButton()
        }
        
        if let alphaMutableViewModel = selected as? AlphaMutable {
            displayAlpha(alphaMutableViewModel)
        } else {
            clearAlphaSlider()
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
    
    private func displaySize(_ selected: ViewModel) {
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
    
    private func displayOrigin(_ selected: ViewModel) {
        xOriginStepper.isEnabled = true
        yOriginStepper.isEnabled = true
        
        let selectedX = selected.origin.x
        let selectedY = selected.origin.y
        
        xOriginStepper.value = selectedX
        yOriginStepper.value = selectedY
        
        xOriginLabel.text = String(format: "%.0f", selectedX)
        yOriginLabel.text = String(format: "%.0f", selectedY)
        
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
    }
    
    private func clearOriginStepper() {
        xOriginLabel.text = ""
        yOriginLabel.text = ""
        
        xOriginStepper.isEnabled = false
        yOriginStepper.isEnabled = false
    }
}

// MARK: - Use case: Mutate View using Controls

extension PanelViewController {
    
    @IBAction func ColorButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: PanelViewController.event.colorButtonPressed, object: self)
    }
    
    @objc func didMutateColor(_ notification: Notification) {
        guard let plane = notification.object as? Plane else { return }
        guard let mutated = plane.selected as? ColorMutable else { return }
        displayColor(mutated)
    }
    
    @IBAction func SliderChanged(_ sender: UISlider) {
        NotificationCenter.default.post(name: PanelViewController.event.sliderChanged, object: self, userInfo: [PanelViewController.InfoKey.sliderValue: sender.value])
    }
    
    @objc func didMutateAlpha(_ notification: Notification) {
        guard let plane = notification.object as? Plane else { return }
        guard let mutated = plane.selected as? AlphaMutable else { return }
        displayAlpha(mutated)
    }
    
    @objc func didMutateSize(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.mutated] as? ViewModel else { return }
        displaySize(mutated)
    }
    
    @objc func didMutateOrigin(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.mutated] as? ViewModel else { return }
        displayOrigin(mutated)
    }
}

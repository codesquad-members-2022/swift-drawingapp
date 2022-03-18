//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var presentShapeView = UIView()
    private var sideInspectorView = SideInspectorView()
    private var buttonView = ButtonView()
    
    private var plane = Plane()
    private var shapeMap = [BasicShape: BasicShapeView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        addObservers()
        
        //Add Action
        buttonView.rectangleButton.addTarget(self, action: #selector(addRectangleButtonTouched), for: .touchUpInside)
        buttonView.pictureButton.addTarget(self, action: #selector(addPictureButtonTouched), for: .touchUpInside)
        sideInspectorView.backgroundColorValueButton.addTarget(self, action: #selector(backgroundColorValueButtonTouched), for: .touchUpInside)
        sideInspectorView.alphaPlusButton.addTarget(self, action: #selector(alphaPlusButtonTouched), for: .touchUpInside)
        sideInspectorView.alphaMinusButton.addTarget(self, action: #selector(alphaMinusButtonTouched), for: .touchUpInside)
        
        //Add Gesture Recognizer
        let presentRectangleViewTap = UITapGestureRecognizer(target: self, action: #selector(handlePresentShapeViewTap(_:)))
        presentShapeView.addGestureRecognizer(presentRectangleViewTap)
    }
    
    //MARK: Set Up Views
    
    private func setUpViews() {
        view.addSubview(presentShapeView)
        view.addSubview(sideInspectorView)
        view.addSubview(buttonView)
        
        layoutPresentRectangleView()
        layoutSideInspectorView()
        layoutAddRectangleButton()
    }
}

//MARK: Add Constraints

extension ViewController {
    
    func layoutPresentRectangleView() {
        presentShapeView.translatesAutoresizingMaskIntoConstraints = false
        presentShapeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        presentShapeView.bottomAnchor.constraint(equalTo: buttonView.topAnchor).isActive = true
        presentShapeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentShapeView.trailingAnchor.constraint(equalTo: sideInspectorView.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    func layoutAddRectangleButton() {
        buttonView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: sideInspectorView.leadingAnchor).isActive = true
    }
    
    func layoutSideInspectorView() {
        sideInspectorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sideInspectorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sideInspectorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sideInspectorView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

//MARK: Actions

extension ViewController {
    @objc func addRectangleButtonTouched() {
        let rectangleViewXBound = presentShapeView.frame.width - Size.Range.width
        let rectangleViewYBound = presentShapeView.frame.height - Size.Range.height
        plane.addRectangle(bound: (rectangleViewXBound, rectangleViewYBound), by: RandomShapeFactory.self)
    }
    
    @objc func addPictureButtonTouched() {

    }
    
    @objc func handlePresentShapeViewTap(_ tap: UITapGestureRecognizer) {
        guard tap.state == .ended else { return }
        
        let location = tap.location(in: presentShapeView)
        let coordinate = (Double(location.x), Double(location.y))
        plane.searchTopShape(on: coordinate)
    }
    
    @objc func backgroundColorValueButtonTouched() {
        plane.changeBackgroundColor()
    }
    
    @objc func alphaPlusButtonTouched() {
        plane.upAlphaValue()
    }
    
    @objc func alphaMinusButtonTouched() {
        plane.downAlphaValue()
    }
}

//MARK: Observer Selectors

extension ViewController {
    
    @objc func didCreateShape(notification: Notification) {
        guard let shape = notification.userInfo?[Plane.UserInfoKeys.newRectangle] as? BasicShape else { return }
        
        let frame = getCGRect(combinedPoint: shape.combinedOrigin, combinedSize: shape.combinedSize)
        var color: UIColor?
        var alpha: CGFloat?
        
        if let shape = shape as? Colorable {
            color = getUIColor(combinedColor: shape.combinedColor)
        }
        
        if let shape = shape as? Alphable {
            alpha = shape.alphaValue
        }
        
        let shapeView = ViewFactory.createView(frame: frame, backgroundColor: color, alpha: alpha)
        shapeMap[shape] = shapeView
        presentShapeView.addSubview(shapeView)
    }
    
    @objc func didSelectShape(notification: Notification) {
        guard let newlySelectedShape = notification.userInfo?[Plane.UserInfoKeys.newlySelectedShape] as? BasicShape else { return }
        
        if let previouslySelectedShape = notification.userInfo?[Plane.UserInfoKeys.previouslySelectedShape] as? BasicShape {
            let previouslySelectedShapeView = shapeMap[previouslySelectedShape]
            previouslySelectedShapeView?.clearCorner()
        }
        
        let newlySelectedShapeView = shapeMap[newlySelectedShape]
        newlySelectedShapeView?.toggleCorner()
        
        plane.updateSelected(shape: newlySelectedShape)
    }
    
    @objc func didSelectEmptyView(notification: Notification) {
        guard let previouslySelectedShape = notification.userInfo?[Plane.UserInfoKeys.previouslySelectedShape] as? BasicShape else { return }
        let previouslySelectedShapeView = shapeMap[previouslySelectedShape]
        previouslySelectedShapeView?.clearCorner()
        
        sideInspectorView.clearBackgroundColorValueButtonTitle()
        sideInspectorView.clearBackgroundColorValueButtonColor()
        sideInspectorView.clearAlphaValueLabelText()
        
        plane.clearSelected()
    }
    
    @objc func didChangeSelectedShape(notification: Notification) {
        guard let selectedShape = notification.userInfo?[Plane.UserInfoKeys.updatedSelectedShape] as? BasicShape else { return }
        
        if let selectedShape = selectedShape as? Colorable {
            
            let newColor = getUIColor(combinedColor: selectedShape.combinedColor)
            let newColorHexaValue = selectedShape.hexaValue
            sideInspectorView.setBackgroundColorValueButtonColor(by: newColor)
            sideInspectorView.setBackgroundColorValueButtonTitle(by: newColorHexaValue)
        }
        
        if let selectedShape = selectedShape as? Alphable {
            let newAlpha = selectedShape.alphaValue
            sideInspectorView.setAlphaValueLabelText(by: newAlpha)
            sideInspectorView.enableAlphaPlusButton()
            sideInspectorView.enableAlphaMinusButton()
        }
    }
    
    @objc func didUpdateSelectedShapeBackgroundColor(notification: Notification) {
        guard let selectedShape = notification.userInfo?[Plane.UserInfoKeys.selectedShape] as? BasicShape & Colorable else { return }
        let selectedShapeView = shapeMap[selectedShape] as? ViewColorChangable
        
        let newColor = getUIColor(combinedColor: selectedShape.combinedColor)
        let newColorHexaValue = selectedShape.hexaValue
        
        selectedShapeView?.changeBackgroundColor(by: newColor)
        sideInspectorView.setBackgroundColorValueButtonColor(by: newColor)
        sideInspectorView.setBackgroundColorValueButtonTitle(by: newColorHexaValue)
    }
    
    @objc func didUpdateSelectedShapeAlpha(notification: Notification) {
        guard let selectedShape = notification.userInfo?[Plane.UserInfoKeys.selectedShape] as? BasicShape & Alphable else { return }
        let selectedShapeView = shapeMap[selectedShape] as? ViewAlphaChangable
        
        let newAlpha = selectedShape.alphaValue
        selectedShapeView?.changeAlpha(to: newAlpha)
        sideInspectorView.setAlphaValueLabelText(by: selectedShape.alphaValue)
        
        if !selectedShape.canAlphaLevelUp() {
            sideInspectorView.disableAlphaPlusButton()
        }
        else if !selectedShape.canAlphaLevelDown() {
            sideInspectorView.disableAlphaMinusButton()
        }
        else {
            sideInspectorView.enableAlphaPlusButton()
            sideInspectorView.enableAlphaMinusButton()
        }
    }
    
}

extension ViewController {
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didCreateShape(notification:)),
                                               name: Plane.EventName.newShapeDidCreate,
                                               object: plane)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSelectShape(notification:)),
                                               name: Plane.EventName.shapeDidSelect,
                                               object: plane)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSelectEmptyView(notification:)),
                                               name: Plane.EventName.emptyViewDidSelect,
                                               object: plane)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeSelectedShape(notification:)),
                                               name: Plane.EventName.selectedShapeDidChange,
                                               object: plane)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didUpdateSelectedShapeBackgroundColor(notification:)),
                                               name: Plane.EventName.selectedShapeDidUpdateBackgroundColor,
                                               object: plane)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didUpdateSelectedShapeAlpha(notification:)),
                                               name: Plane.EventName.selectedShapeDidUpdateAlpha,
                                               object: plane)
    }
}

//MARK: Private Functions

extension ViewController {
    private func getUIColor(combinedColor: (red: Double, green: Double, blue: Double, alpha: Double)) -> UIColor {
        let color = UIColor(red: combinedColor.red,
                        green: combinedColor.green,
                        blue: combinedColor.blue,
                        alpha: combinedColor.alpha)
        return color
    }
    
    private func getCGRect(combinedPoint: (x: Double, y: Double), combinedSize: (width: Double, height: Double)) -> CGRect {
        let rect = CGRect(origin: CGPoint(x: combinedPoint.x, y: combinedPoint.y),
                            size: CGSize(width: combinedSize.width, height: combinedSize.height))
        return rect
    }
}

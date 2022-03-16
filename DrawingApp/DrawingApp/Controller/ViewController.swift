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
    private var addRectangleButton = AddRectangleButton()
    
    private var plane = Plane()
    private var shapeMap = [BasicShape: BasicShapeView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plane.delegate = self
        
        setUpViews()
        
        //Add Action
        addRectangleButton.addTarget(self, action: #selector(addRectangleButtonTouched), for: .touchUpInside)
        sideInspectorView.backgroundColorValueButton.addTarget(self, action: #selector(backgroundColorValueButtonTouched), for: .touchUpInside)
        sideInspectorView.alphaPlusButton.addTarget(self, action: #selector(alphaPlusButtonTouched), for: .touchUpInside)
        sideInspectorView.alphaMinusButton.addTarget(self, action: #selector(alphaMinusButtonTouched), for: .touchUpInside)
        
        //Add Gesture Recognizer
        let presentRectangleViewTap = UITapGestureRecognizer(target: self, action: #selector(handlePresentShapeViewTap(_:)))
        presentShapeView.addGestureRecognizer(presentRectangleViewTap)
    }
    
    //MARK: Set Up Views
    
    func setUpViews() {
        view.addSubview(presentShapeView)
        view.addSubview(sideInspectorView)
        view.addSubview(addRectangleButton)
        
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
        presentShapeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentShapeView.trailingAnchor.constraint(equalTo: sideInspectorView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentShapeView.bottomAnchor.constraint(equalTo: addRectangleButton.topAnchor).isActive = true
    }
    
    func layoutAddRectangleButton() {
        addRectangleButton.centerXAnchor.constraint(equalTo: presentShapeView.centerXAnchor).isActive = true
        addRectangleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addRectangleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addRectangleButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func layoutSideInspectorView() {
        sideInspectorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sideInspectorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
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

//MARK: Delegates

extension ViewController: PlaneDelegate {
    
    func didCreateShape(_ shape: BasicShape) {
        let frame = CGConverter.toCGRect(from: (shape.point, shape.size))
        var color: UIColor?
        var alpha: CGFloat?
        
        if let shape = shape as? Colorable & Alphable {
            color = CGConverter.toUIColor(from: shape.backgroundColor)
            alpha = CGConverter.toCGFloat(from: shape.alpha)
        }
        
        let shapeView = ViewFactory.createView(frame: frame, backgroundColor: color, alpha: alpha)
        shapeMap[shape] = shapeView
        presentShapeView.addSubview(shapeView)
    }
    
    func didSelectShape(_ shape: BasicShape) {
        if let selectedShape = plane.selected,
           let selectedShapeView = shapeMap[selectedShape] {
            selectedShapeView.clearCorner()
        }
        
        let shapeView = shapeMap[shape]
        shapeView?.toggleCorner()
        plane.updateSelected(shape: shape)
    }
    
    func didSelectEmptyView() {
        guard let selectedShape = plane.selected,
            let selectedShapeView = shapeMap[selectedShape] else { return }
        
        selectedShapeView.clearCorner()
        sideInspectorView.clearBackgroundColorValueButtonTitle()
        sideInspectorView.clearBackgroundColorValueButtonColor()
        sideInspectorView.clearAlphaValueLabelText()
        
        plane.clearSelected()
    }
    
    func didChangeSelectedShape(_ shape: BasicShape) {
        if let shape = shape as? Colorable {
            let newColor = CGConverter.toUIColor(from: shape.backgroundColor)
            let newColorHexaValue = shape.hexaValue
            sideInspectorView.setBackgroundColorValueButtonColor(by: newColor)
            sideInspectorView.setBackgroundColorValueButtonTitle(by: newColorHexaValue)
        }
        
        if let shape = shape as? Alphable {
            let newAlpha = CGConverter.toCGFloat(from: shape.alpha)
            sideInspectorView.setAlphaValueLabelText(by: Float(newAlpha))
            sideInspectorView.enableAlphaPlusButton()
            sideInspectorView.enableAlphaMinusButton()
        }
    }
    
    func didUpdateSelectedShapeBackgroundColor(_ shape: BasicShape & Colorable) {
        guard let selectedShapeView = shapeMap[shape] as? ViewColorChangable else { return }
        let newColor = CGConverter.toUIColor(from: shape.backgroundColor)
        let newColorHexaValue = shape.hexaValue
        
        selectedShapeView.changeBackgroundColor(by: newColor)
        sideInspectorView.setBackgroundColorValueButtonColor(by: newColor)
        sideInspectorView.setBackgroundColorValueButtonTitle(by: newColorHexaValue)
    }
    
    func didUpdateSelectedShapeAlpha(_ shape: BasicShape & Alphable) {
        guard let selectedShapeView = shapeMap[shape] as? ViewAlphaChangable else { return }
        let newAlpha = CGConverter.toCGFloat(from: shape.alpha)
        
        selectedShapeView.changeAlpha(to: newAlpha)
        sideInspectorView.setAlphaValueLabelText(by: shape.alphaValue)
        
        if !shape.canAlphaLevelUp() {
            sideInspectorView.disableAlphaPlusButton()
        }
        else if !shape.canAlphaLevelDown() {
            sideInspectorView.disableAlphaMinusButton()
        }
        else {
            sideInspectorView.enableAlphaPlusButton()
            sideInspectorView.enableAlphaMinusButton()
        }
    }
    
}

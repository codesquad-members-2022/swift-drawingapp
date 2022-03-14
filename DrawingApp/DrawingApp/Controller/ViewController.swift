//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var presentRectangleView = UIView()
    private var sideInspectorView = SideInspectorView()
    private var addRectangleButton = AddRectangleButton()
    
    private var plane = Plane()
    private var rectangleMap = [Rectangle : RectangleView]()
    
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
        let presentRectangleViewTap = UITapGestureRecognizer(target: self, action: #selector(handlePresentRectangleViewTap(_:)))
        presentRectangleView.addGestureRecognizer(presentRectangleViewTap)
    }
    
    //MARK: Set Up Views
    
    func setUpViews() {
        view.addSubview(presentRectangleView)
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
        presentRectangleView.translatesAutoresizingMaskIntoConstraints = false
        presentRectangleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        presentRectangleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentRectangleView.trailingAnchor.constraint(equalTo: sideInspectorView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentRectangleView.bottomAnchor.constraint(equalTo: addRectangleButton.topAnchor).isActive = true
    }
    
    func layoutAddRectangleButton() {
        addRectangleButton.centerXAnchor.constraint(equalTo: presentRectangleView.centerXAnchor).isActive = true
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
        let rectangleViewXBound = presentRectangleView.frame.width - Size.Range.width
        let rectangleViewYBound = presentRectangleView.frame.height - Size.Range.height

        let newRectangle = RandomRectangleFactory.createRandomRectangle(xBound: rectangleViewXBound, yBound: rectangleViewYBound)
        plane.append(newRectangle: newRectangle)
    }

    @objc func handlePresentRectangleViewTap(_ tap: UITapGestureRecognizer) {
        guard tap.state == .ended else { return }
        
        let location = tap.location(in: presentRectangleView)
        let coordinate = (Double(location.x), Double(location.y))
        plane.searchRectangle(on: coordinate)
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
    
    func didCreateRectangle(_ rectangle: Rectangle) {
        let backgroundColor = rectangle.getUIColor()
        let frame = rectangle.getFrame()
        let alpha = rectangle.getAlpha()
        let rectangleView = RectangleView(frame: frame, backgroundColor: backgroundColor, alpha: alpha)
        
        presentRectangleView.addSubview(rectangleView)
        rectangleMap[rectangle] = rectangleView
    }
    
    func didSelectRectanlge(_ rectangle: Rectangle) {
        if let recentlySelectedRectangle = plane.recentlySelectedRectangle,
           let recentlySelectedRectangleView = rectangleMap[recentlySelectedRectangle] {
            recentlySelectedRectangleView.clearCorner()
        }
        
        let rectangleView = rectangleMap[rectangle]
        rectangleView?.toggleCorner()
        plane.updateRecentlySelected(rectangle: rectangle)
    }
    
    func didSelectEmptyView() {
        guard let recentlySelectedRectangle = plane.recentlySelectedRectangle,
            let recentlySelectedRectangleView = rectangleMap[recentlySelectedRectangle] else { return }
        
        recentlySelectedRectangleView.clearCorner()
        sideInspectorView.clearBackgroundColorValueButtonTitle()
        sideInspectorView.clearBackgroundColorValueButtonColor()
        sideInspectorView.clearAlphaValueLabelText()
    }
    
    func didUpdateRecentlySelectedRectangle(_ rectangle: Rectangle) {
        let newColor = rectangle.getUIColor()
        let newColorHexaValue = rectangle.getColorHexaValue()
        let newAlpha = rectangle.getTransparency()
        
        sideInspectorView.setBackgroundColorValueButtonTitle(by: newColorHexaValue)
        sideInspectorView.setBackgroundColorValueButtonColor(by: newColor)
        sideInspectorView.setAlphaValueLabelText(by: newAlpha)
    }
    
    func didUpdateRecentlySelectedRectangleBackgroundColor(_ rectangle: Rectangle) {
        guard let selectedRectangleView = rectangleMap[rectangle] else { return }
        let newColor = rectangle.getUIColor()
        let newColorHexaValue = rectangle.getColorHexaValue()
        
        selectedRectangleView.changeBackgroundColor(by: newColor)
        sideInspectorView.setBackgroundColorValueButtonColor(by: newColor)
        sideInspectorView.setBackgroundColorValueButtonTitle(by: newColorHexaValue)
    }
    
    func didUpdateRecentlySelectedRectangleAlpha(_ rectangle: Rectangle) {
        guard let selectedRectangleView = rectangleMap[rectangle] else { return }
        let newAlpha = rectangle.getTransparency()
        
        selectedRectangleView.changeAlpha(to: CGFloat(newAlpha))
        sideInspectorView.setAlphaValueLabelText(by: newAlpha)
        
        if !rectangle.canAlphaLevelUp() {
            sideInspectorView.disableAlphaPlusButton()
        }
        else if !rectangle.canAlphaLevelDown() {
            sideInspectorView.disableAlphaMinusButton()
        }
        else {
            sideInspectorView.enableAlphaPlusButton()
            sideInspectorView.enableAlphaMinusButton()
        }
    }
    
}


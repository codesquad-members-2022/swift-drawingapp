//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class MainViewController: UIViewController, RightAttributerViewDelegate{
    private var plane = Plane()
    let rectFactory = RectangleFactory()
    let rightAttributerView = RightAttributerView()
    
    private var rectangleUIViews = [String : UIView]()
    private var selectedRectangle: Rectangle?
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
        rightAttributerView.delegate = self
        self.view.addSubview(rightAttributerView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        addRectangleMakerButtonObserver()
        addGestureRecognizerObserver()
    }
    
    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleValue = rectFactory.makeRectangle(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
        plane.addRectangle(rectangle: rectangleValue)
    }
    
    @objc func addRectangleView(_ notification: Notification){
        guard let rectangleValue = notification.userInfo?["rectangle"] as? Rectangle else { return }
        
        let rectangleView = RandomRectangleView(frame: CGRect(x: rectangleValue.point.x, y: rectangleValue.point.y, width: rectangleValue.size.width, height: rectangleValue.size.height))
        rectangleView.backgroundColor = UIColor(red: rectangleValue.showColor().redValue(), green: rectangleValue.showColor().blueValue(), blue: rectangleValue.showColor().greenValue(), alpha: rectangleValue.showAlpha().showValue())
        rectangleView.restorationIdentifier = rectangleValue.id
        
        self.view.addSubview(rectangleView)
        rectangleUIViews[rectangleValue.id] = rectangleView
        
        os_log("%@", "\(rectangleValue.description)")
    }
}


// MARK: - Use case: Add observers

extension MainViewController{
    private func addRectangleMakerButtonObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(addRectangleView(_:)), name: Plane.makeRectangle, object: nil)
    }
    
    private func addGestureRecognizerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(assignSelectRectangle(_:)), name: Plane.selectRectangle, object: nil)
    }
}


// MARK: - Use case: Click Rectangle

extension MainViewController {
    @objc func tapGesture(_ gesture: UITapGestureRecognizer){
        let touchPoint = gesture.location(in: self.view)
        plane.findRectangle(withX: touchPoint.x, withY: touchPoint.y)
        displaySliderValue()
        
        return
    }
    
    @objc func assignSelectRectangle(_ notification: Notification){
        guard let rectangle = notification.userInfo?["rectangle"] as? Rectangle, let _ = rectangleUIViews[rectangle.id] else{
            return
        }
        
        selectedRectangle = rectangle
    }
    
    private func displaySliderValue(){
        guard let rectangle = selectedRectangle else{
            return
        }
        
        rightAttributerView.originSliderValue(red: Float(rectangle.showColor().red), green: Float(rectangle.showColor().green), blue: Float(rectangle.showColor().blue), alpha: Float(rectangle.showAlpha().showValue()))
    }
}

// MARK: - Use case: Control RigthAttributerView's sliders

extension MainViewController{
    func moveAlphaSlider() {
        changeRectangleAlpha()
        rightAttributerView.changeAlphaSliderView(text: "투명도 : \(String(format: "%.0f", rightAttributerView.alphaValue.showValue() * 10))")
    }
    
    func moveRedSlider() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Red : \(String(format: "%.0f", rightAttributerView.redValue))")
    }
    
    func moveGreenSlider() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Green : \(String(format: "%.0f", rightAttributerView.greenValue))")
    }
    
    func moveBlueSlider() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Blue : \(String(format: "%.0f", rightAttributerView.blueValue))")
    }
    
    func changeRectangleColor(){
        guard let rectangle = selectedRectangle, let rectView = rectangleUIViews[rectangle.id] else{
            return
        }
        
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        rectangle.changeColor(color: newColor)
        
        rectView.backgroundColor = UIColor(red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
    }
    
    func changeRectangleAlpha(){
        guard let rectangle = selectedRectangle, let rectView = rectangleUIViews[rectangle.id] else{
            return
        }
        
        let newAlpha = rightAttributerView.alphaValue
        rectangle.changeAlpha(alpha: newAlpha)
        
        rectView.backgroundColor = rectView.backgroundColor?.withAlphaComponent(rectangle.showAlpha().showValue())
    }
}

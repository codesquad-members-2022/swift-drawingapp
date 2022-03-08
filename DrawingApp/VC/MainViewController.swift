//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class MainViewController: UIViewController, UIColorSliderDelegate{
    private var plane = Plane()
    let rectFactory = RectangleFactory()
    let rightAttributerView = RightAttributerView()
    
    private var rectangleUIViews = [Rectangle : RectangleView]()
    private var selectedRectangle: Rectangle?
    private var selectedRectangleView: RectangleView?
    
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
        addNoneClickedRectangleObserver()
    }
    
    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleValue = rectFactory.makeRandomRectangle(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
        plane.addRectangle(rectangle: rectangleValue)
    }
    
    @objc func addRectangleView(_ notification: Notification){
        guard let rectangleValue = notification.userInfo?[Plane.userInfoKey] as? Rectangle else { return }
        
        let rectangleView = RectangleView(frame: CGRect(x: rectangleValue.point.x, y: rectangleValue.point.y, width: rectangleValue.size.width, height: rectangleValue.size.height))
        rectangleView.backgroundColor = UIColor(red: rectangleValue.showColor().redValue(), green: rectangleValue.showColor().blueValue(), blue: rectangleValue.showColor().greenValue(), alpha: rectangleValue.showAlpha().showValue())
        rectangleView.restorationIdentifier = rectangleValue.id
        
        self.view.addSubview(rectangleView)
        rectangleUIViews[rectangleValue] = rectangleView
        
        os_log("%@", "\(rectangleValue.description)")
    }
}


// MARK: - Use case: Add observers

extension MainViewController{
    private func addRectangleMakerButtonObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(addRectangleView(_:)), name: Plane.makeRectangle, object: plane)
    }
    
    private func addGestureRecognizerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showTouchedView(_:)), name: Plane.selectRectangle, object: plane)
    }
    
    private func addNoneClickedRectangleObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showNonTouchedView), name: Plane.noneSelectRectangle, object: plane)
    }
}


// MARK: - Use case: Click Rectangle

extension MainViewController {
    @objc func tapGesture(_ gesture: UITapGestureRecognizer){
        let touchPoint = gesture.location(in: self.view)
        plane.findRectangle(withX: touchPoint.x, withY: touchPoint.y)
        
        return
    }
    
    @objc func showTouchedView(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.userInfoKey] as? Rectangle, let rectangleView = rectangleUIViews[rectangle] else{
            return
        }
        
        selectedRectangle = rectangle
        selectedRectangleView = rectangleView
        
        displaySliderValue(rectangle: rectangle)
        touchedViewFrame(view: rectangleView)
    }
    
    private func displaySliderValue(rectangle: Rectangle){
        rightAttributerView.originSliderValue(red: Float(rectangle.showColor().red), green: Float(rectangle.showColor().green), blue: Float(rectangle.showColor().blue), alpha: Float(rectangle.showAlpha().showValue()))
    }
    
    private func touchedViewFrame(view: RectangleView){
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.borderWidth = 3
    }
    
    @objc func showNonTouchedView(){
        guard let rectangle = selectedRectangle, let view = selectedRectangleView else{
            return
        }
        
        noneTouchedViewFrame(view: view)
        noneDisplaySliderValue(rectangle: rectangle)
        
        self.selectedRectangle = nil
        self.selectedRectangleView = nil
    }
    
    private func noneDisplaySliderValue(rectangle: Rectangle){
        rightAttributerView.originSliderValue(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    private func noneTouchedViewFrame(view: RectangleView){
        view.layer.borderColor = .none
        view.layer.borderWidth = 0
    }
}

// MARK: - Use case: Control RigthAttributerView's sliders

extension MainViewController{
    func alphaSliderDidMove() {
        changeRectangleAlpha()
        rightAttributerView.changeAlphaSliderView(text: "투명도 : \(String(format: "%.0f", rightAttributerView.alphaValue.showValue() * 10))")
    }
    
    func redSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Red : \(String(format: "%.0f", rightAttributerView.redValue))")
    }
    
    func greenSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Green : \(String(format: "%.0f", rightAttributerView.greenValue))")
    }
    
    func blueSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Blue : \(String(format: "%.0f", rightAttributerView.blueValue))")
    }
    
    func changeRectangleColor(){
        guard let rectangle = selectedRectangle, let rectView = rectangleUIViews[rectangle] else{
            return
        }
        
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        rectangle.changeColor(color: newColor)
        
        rectView.backgroundColor = UIColor(red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
    }
    
    func changeRectangleAlpha(){
        guard let rectangle = selectedRectangle, let rectView = rectangleUIViews[rectangle] else{
            return
        }
        
        let newAlpha = rightAttributerView.alphaValue
        rectangle.changeAlpha(alpha: newAlpha)
        
        rectView.backgroundColor = rectView.backgroundColor?.withAlphaComponent(rectangle.showAlpha().showValue())
    }
}

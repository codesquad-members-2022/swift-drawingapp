//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class MainViewController: UIViewController{
    private var rectangles = Plane()
    let rectFactory = RectangleFactory()
    let rightAttributerView = RightAttributerView()
    
    private var selectedRectangleView: UIView?
    private var selectedRectangleIndex: Int?
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
        self.view.addSubview(rightAttributerView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        addRectangleMakerButtonObserver()
        addTapGestureObserver()
        addSlidersObserver()
    }

    @IBAction func makeRandomRectangle(_ sender: Any) {
        NotificationCenter.default.post(name: .makeRectangle, object: nil)
    }
    
    @objc func rectangleMaker(){
        let rectangleValue = Rectangle(id: IDFactory.makeID(), size: rectFactory.makeSize(), point: rectFactory.makePoint(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY), color: rectFactory.makeColor(), alpha: rectFactory.makeAlpha())
        let rectangleView = RandomRectangleView(id: rectangleValue.id, point: rectangleValue.point, size: rectangleValue.size, color: rectangleValue.showColor(), alpha: rectangleValue.showAlpha())
        
        rectangles.addRectangle(rectangle: rectangleValue)

        os_log("%@", "\(rectangleValue.description)")
        self.view.addSubview(rectangleView)
    }
}


// MARK: - Use case: Add observers

extension MainViewController{
    private func addRectangleMakerButtonObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(rectangleMaker), name: .makeRectangle, object: nil)
    }
    
    private func addTapGestureObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showOriginSliderValue), name: .tapGesture, object: nil)
    }
    
    private func addSlidersObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(moveAlphaSlider), name: .changeAlpha, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveRedSlider), name: .changeRedColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveGreenSlider), name: .changeGreenColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveBlueSlider), name: .changeBlueColor, object: nil)
    }
}


// MARK: - Use case: Click Rectangle

extension MainViewController {
    @objc func tapGesture(_ gesture: UITapGestureRecognizer){
        let touchPoint = gesture.location(in: self.view)
        findSelectedRectangle(point: touchPoint)
        
        NotificationCenter.default.post(name: .tapGesture, object: nil)
        
        return
    }
    
    private func findSelectedRectangle(point: CGPoint){
        guard let rectangleInPlane = rectangles.findRectangle(withX: point.x, withY: point.y) else{
            return
        }
        
        let rectangleView = self.view.hitTest(point, with: nil)
        
        if rectangleView?.restorationIdentifier == rectangleInPlane.id{
            self.selectedRectangleView = rectangleView
            self.selectedRectangleIndex = rectangles.findRectangleIndex(rectangle: rectangleInPlane)
        } else{
            return
        }
    }
    
    @objc func showOriginSliderValue(){
        guard let index = selectedRectangleIndex, let rectangle = self.rectangles[index] else{
            return
        }
        
        rightAttributerView.originSliderValue(red: Float(rectangle.showColor().red), green: Float(rectangle.showColor().green), blue: Float(rectangle.showColor().blue), alpha: Float(rectangle.showAlpha().showValue()))
    }
}


// MARK: - Use case: Control RigthAttributerView's sliders

extension MainViewController{
    @objc func moveAlphaSlider() {
        changeRectangleAlpha()
        rightAttributerView.changeAlphaSliderView(text: "투명도 : \(String(format: "%.0f", rightAttributerView.alphaValue.showValue() * 10))")
    }
    
    @objc func moveRedSlider() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Red : \(String(format: "%.0f", rightAttributerView.redValue))")
    }
    
    @objc func moveGreenSlider() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Green : \(String(format: "%.0f", rightAttributerView.greenValue))")
    }
    
    @objc func moveBlueSlider() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Blue : \(String(format: "%.0f", rightAttributerView.blueValue))")
    }
    
    func changeRectangleColor(){
        guard let index = selectedRectangleIndex, let rectangle = self.rectangles[index], let rectView = selectedRectangleView else{
            return
        }
        
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        rectangle.changeColor(color: newColor)
        
        rectView.backgroundColor = UIColor(red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
    }
    
    func changeRectangleAlpha(){
        guard let index = selectedRectangleIndex, let rectangle = self.rectangles[index], let rectView = selectedRectangleView else{
            return
        }
        
        let newAlpha = rightAttributerView.alphaValue
        rectangle.changeAlpha(alpha: newAlpha)
        
        rectView.backgroundColor = rectView.backgroundColor?.withAlphaComponent(rectangle.showAlpha().showValue())
    }
}

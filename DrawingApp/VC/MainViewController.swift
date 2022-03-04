//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class MainViewController: UIViewController, RightAttributerViewDelegate {
    private var rectangles = Plane()
    let rectFactory = RectangleFactory()
    let rightAttributerView = RightAttributerView()
    
    private var selectedRectangleView: UIView?
    private var selectedRectangleIndex: Int?
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
        rightAttributerView.delegate = self
        self.view.addSubview(rightAttributerView)
        rightAttributerView.layout()
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func moveAlphaSlider() {
        changeRectangleAlpha()
    }
    
    func moveRedSlider() {
        changeRectangleColor()
    }
    
    func moveGreenSlider() {
        changeRectangleColor()
    }
    
    func moveBlueSlider() {
        changeRectangleColor()
    }
    
    func changeRectangleColor(){
        guard let index = selectedRectangleIndex, let rectangle = self.rectangles[index], let rectView = selectedRectangleView else{
            return
        }
        
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        rectangle.changeColor(color: newColor)
        
        rectView.backgroundColor = UIColor(red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())

        rightAttributerView.changeColorSliderValue()
    }
    
    func changeRectangleAlpha(){
        guard let index = selectedRectangleIndex, let rectangle = self.rectangles[index], let rectView = selectedRectangleView else{
            return
        }
        
        let newAlpha = rightAttributerView.alphaValue
        rectangle.changeAlpha(alpha: newAlpha)
        
        rectView.backgroundColor = rectView.backgroundColor?.withAlphaComponent(rectangle.showAlpha().showValue())
        
        rightAttributerView.changeAlphaSliderView()
    }

    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleView = RandomRectangleView()
        let rectangleValue = Rectangle(id: IDFactory.makeID(), size: rectFactory.makeSize(), point: rectFactory.makePoint(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY), color: rectFactory.makeColor(), alpha: rectFactory.makeAlpha())
        
        rectangles.addRectangle(rectangle: rectangleValue)
        rectangleView.attribute(rectangle: rectangleValue)
        rectangleView.layout(rectangle: rectangleValue)

        os_log("%@", "\(rectangleValue.description)")
        self.view.addSubview(rectangleView)
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: self.view)
        findSelectedRectangle(point: touchPoint)
        
        guard let index = selectedRectangleIndex, let rectangle = self.rectangles[index] else{
            return true
        }
        
        rightAttributerView.originSliderValue(red: Float(rectangle.showColor().red), green: Float(rectangle.showColor().green), blue: Float(rectangle.showColor().blue), alpha: Float(rectangle.showAlpha().showValue()))
        
        return true
    }
    
    private func findSelectedRectangle(point: CGPoint){
        guard let rectangleInPlane = rectangles.findRectangle(withX: point.x, withY: point.y), let rectangleView = rectangles.findRectangleView(view: self.view, rectangle: rectangleInPlane) else{
            return
        }
        
        self.selectedRectangleView = rectangleView
        self.selectedRectangleIndex = rectangles.findRectangleIndex(rectangle: rectangleInPlane)
    }
}

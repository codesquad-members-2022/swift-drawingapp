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
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
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

    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleValue = Rectangle(id: IDFactory.makeID(), size: rectFactory.makeSize(), point: rectFactory.makePoint(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY), color: rectFactory.makeColor(), alpha: rectFactory.makeAlpha())
        let rectangleView = RandomRectangleView(id: rectangleValue.id, point: rectangleValue.point, size: rectangleValue.size, color: rectangleValue.showColor(), alpha: rectangleValue.showAlpha())
        
        rectangles.addRectangle(rectangle: rectangleValue)

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
}

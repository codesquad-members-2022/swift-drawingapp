//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class MainViewController: UIViewController {
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
        
        rightAttributerView.redSlider.addTarget(self, action: #selector(self.changeRectangleAttribute), for: .valueChanged)
        rightAttributerView.greenSlider.addTarget(self, action: #selector(self.changeRectangleAttribute), for: .valueChanged)
        rightAttributerView.blueSlider.addTarget(self, action: #selector(self.changeRectangleAttribute), for: .valueChanged)
        rightAttributerView.alphaSlider.addTarget(self, action: #selector(self.changeRectangleAttribute), for: .valueChanged)
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    @IBAction func makeRandomRectangle(_ sender: Any) {
        let uiViewClass = RandomRectangleView()
        let rectangleValue = Rectangle(id: IDFactory.makeID(), size: rectFactory.makeSize(), point: rectFactory.makePoint(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY), color: rectFactory.makeColor(), alpha: rectFactory.makeAlpha())
        
        rectangles.addRectangle(rectangle: rectangleValue)
        let rectangleView = uiViewClass.makeRectangleView(rectangle: rectangleValue)

        os_log("%@", "\(rectangleValue.description)")
        self.view.addSubview(rectangleView)
    }
    
    @objc func changeRectangleAttribute(){
        guard let index = selectedRectangleIndex, let rectangle = self.rectangles[index], let rectView = selectedRectangleView else{
            return
        }
        
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        let newAlpha = rightAttributerView.alphaValue 
        
        rectangle.changeAlpha(alpha: newAlpha)
        rectangle.changeColor(color: newColor)
        
        rectView.backgroundColor = UIColor(red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
        
        rightAttributerView.changeAllSliderValue()
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: self.view)
        findSelectedRectangle(point: touchPoint)
        
        guard let index = selectedRectangleIndex, let rectangle = self.rectangles[index] else{
            return true
        }
        
        rightAttributerView.changeAlphaSliderValue(value: Float(rectangle.showAlpha().showValue()))
        rightAttributerView.changeRedSliderValue(value: Float(rectangle.showColor().red))
        rightAttributerView.changeGreenSliderValue(value: Float(rectangle.showColor().green))
        rightAttributerView.changeBlueSliderValue(value: Float(rectangle.showColor().blue))
        
        return true
    }
    
    private func findSelectedRectangle(point: CGPoint){
        guard let rectangleInPlane = rectangles.findRectangle(withX: point.x, withY: point.y) else{
            return
        }
        
        self.view.subviews.forEach{ rectangle in
            guard rectangle.restorationIdentifier == rectangleInPlane.id else{
                return
            }
            self.selectedRectangleView = rectangle
            self.selectedRectangleIndex = rectangles.findRectangleIndex(rectangle: rectangleInPlane)
        }
    }
}

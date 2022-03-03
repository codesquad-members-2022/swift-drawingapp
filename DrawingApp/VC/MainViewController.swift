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
    private let rectangleMaker = RandomRectangleMaker()
    let rightAttributerView = RightAttributerView()
    
    private var selectedRectangleView: UIView?
    private var selectedRectangleIndex: Int?
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
        self.view.addSubview(rightAttributerView)
        rightAttributerView.layout()
        
        rightAttributerView.redSlider.addTarget(self, action: #selector(self.changeRectangleAttribute), for: .valueChanged)
        rightAttributerView.greenSlider.addTarget(self, action: #selector(self.changeRectangleAttribute), for: .valueChanged)
        rightAttributerView.blueSlider.addTarget(self, action: #selector(self.changeRectangleAttribute), for: .valueChanged)
        rightAttributerView.alphaSlider.addTarget(self, action: #selector(self.changeRectangleAttribute), for: .valueChanged)
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleView = RandomRectangleView()
        rectangleView.makeRectangleView(width: self.rightAttributerView.frame.minX, height: self.rectangleButton.frame.minY)
        
        guard let rectangle = rectangleView.giveRectangle() else{
            let alert = UIAlertController(title: "Warning", message: "사각형 생성에 문제가 있습니다.", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: false)
            return
        }
        
        rectangles.addRectangle(rectangle: rectangle)

        os_log("%@", "\(rectangle.description)")
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
            guard rectangle.restorationIdentifier == rectangleInPlane.showId() else{
                return
            }
            self.selectedRectangleView = rectangle
            self.selectedRectangleIndex = rectangles.findRectangleIndex(rectangle: rectangleInPlane)
        }
    }
}

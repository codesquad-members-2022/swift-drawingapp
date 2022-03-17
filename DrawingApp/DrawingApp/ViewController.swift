//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    var plane = Plane()
    var selectedView: UIView? = nil
    let shapeFactory = ShapeFactory()
    
    @IBOutlet weak var rectangleButton: UIButton!
    @IBOutlet weak var rgbResetButton: UIButton!
    
    @IBOutlet weak var alphaStepper: UIStepper!
    
    @IBOutlet weak var hexValue: UILabel!
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    @IBOutlet weak var alphaValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        disableControlButtons()
        setAlphaStepper()
    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let touchedCGPoint = sender.location(in: self.view)
        let touchedPoint = Point(x: touchedCGPoint.x, y: touchedCGPoint.y)
        let touchedView = self.view.hitTest(touchedCGPoint, with: nil)
        
        var touchedViewRed: CGFloat = 0
        var touchedViewGreen: CGFloat = 0
        var touchedViewBlue: CGFloat = 0
        var touchedViewAlpha: CGFloat = 0
        touchedView?.backgroundColor?.getRed(&touchedViewRed, green: &touchedViewGreen, blue: &touchedViewBlue, alpha: &touchedViewAlpha)
        touchedViewRed = round(touchedViewRed * 255)
        touchedViewGreen = round(touchedViewGreen * 255)
        touchedViewBlue = round(touchedViewBlue * 255)
        touchedViewAlpha = round(touchedViewAlpha * 10)
        let isRectangleAtPoint = plane.isThereARectangle(point: touchedPoint)
        if isRectangleAtPoint, selectedView == nil { // select new Rectangle
            selectedView = touchedView
            touchedView?.layer.borderWidth = 5
            touchedView?.layer.borderColor = UIColor.blue.cgColor
            hexValue.text = convertRGBToHexColorCode(Int(touchedViewRed), Int(touchedViewGreen), Int(touchedViewBlue))
            redValue.text = "R : \(touchedViewRed)"
            greenValue.text = "G : \(touchedViewGreen))"
            blueValue.text = "B : \(touchedViewBlue)"
            alphaValue.text = "A : \(touchedViewAlpha)"
            alphaStepper.value = touchedViewAlpha
            rgbResetButton.isEnabled = true
            alphaStepper.isEnabled = true
        }
        if isRectangleAtPoint, selectedView != nil { // select another Rectangle
            selectedView?.layer.borderWidth = 0
            selectedView = touchedView
            touchedView?.layer.borderWidth = 5
            touchedView?.layer.borderColor = UIColor.blue.cgColor
            hexValue.text = convertRGBToHexColorCode(Int(touchedViewRed), Int(touchedViewGreen), Int(touchedViewBlue))
            redValue.text = "R : \(touchedViewRed)"
            greenValue.text = "G : \(touchedViewGreen)"
            blueValue.text = "B : \(touchedViewBlue)"
            alphaValue.text = "A : \(touchedViewAlpha)"
            alphaStepper.value = touchedViewAlpha
            rgbResetButton.isEnabled = true
            alphaStepper.isEnabled = true
        }
        if !isRectangleAtPoint { // select nothing
            selectedView?.layer.borderWidth = 0
            selectedView = nil
            hexValue.text = "-"
            redValue.text = "-"
            greenValue.text = "-"
            blueValue.text = "-"
            alphaValue.text = "-"
            alphaStepper.value = 1
            rgbResetButton.isEnabled = false
            alphaStepper.isEnabled = false
        }
    }
    
    @IBAction func drawRectangle(_ sender: UIButton) {
        let bounds = UIScreen.main.bounds
        let randomX = Int.random(in: 1...Int(bounds.width))
        let randomY = Int.random(in: 1...Int(bounds.height))
        let randomCGRed = CGFloat(Double.random(in: 0...255) / 255)
        let randomCGGreen = CGFloat(Double.random(in: 0...255) / 255)
        let randomCGBlue = CGFloat(Double.random(in: 0...255) / 255)
        let randomCGAlpha = CGFloat(Double.random(in: 1...10) / 10)
        let rectangleView = UIView(frame: CGRect(x: randomX, y: randomY, width: 150, height: 120))
        rectangleView.backgroundColor = UIColor(red: randomCGRed, green: randomCGGreen, blue: randomCGBlue, alpha: randomCGAlpha)
        self.view.addSubview(rectangleView)
        
        let randomColor = Color(r: Int(randomCGRed * 255), g: Int(randomCGGreen * 255), b: Int(randomCGBlue * 255))
        let randomAlpha: Alpha = Alpha(rawValue: Int(randomCGAlpha * 10))!
        let rectangle = shapeFactory.createRectangle(
            point: Point(x: Double(randomX), y: Double(randomY)),
            size: Size(width: 150, height: 120),
            color: randomColor, alpha: randomAlpha)
        plane.addRectangle(rectangle)
    }
    
    @IBAction func resetRGB(_ sender: UIButton) {
        guard let currentView = selectedView else {
            return
        }
        var randomCGRed = CGFloat(Double.random(in: 0...255) / 255)
        var randomCGGreen = CGFloat(Double.random(in: 0...255) / 255)
        var randomCGBlue = CGFloat(Double.random(in: 0...255) / 255)
        selectedView?.backgroundColor = UIColor(red: randomCGRed, green: randomCGGreen, blue: randomCGBlue, alpha: currentView.alpha)
        randomCGRed = round(randomCGRed * 255)
        randomCGGreen = round(randomCGGreen * 255)
        randomCGBlue = round(randomCGBlue * 255)
        
        hexValue.text = convertRGBToHexColorCode(Int(randomCGRed), Int(randomCGGreen), Int(randomCGBlue))
        redValue.text = "R : \(randomCGRed)"
        greenValue.text = "G : \(randomCGGreen)"
        blueValue.text = "B : \(randomCGBlue)"
    }
    
    @IBAction func tapAlphaStepper(_ sender: UIStepper) {
        var selectedViewRed: CGFloat = 0
        var selectedViewGreen: CGFloat = 0
        var selectedViewBlue: CGFloat = 0
        var selectedViewAlpha: CGFloat = 0
        selectedView?.backgroundColor?.getRed(&selectedViewRed, green: &selectedViewGreen, blue: &selectedViewBlue, alpha: &selectedViewAlpha)
        selectedView?.backgroundColor = UIColor(red: selectedViewRed, green: selectedViewGreen, blue: selectedViewBlue, alpha: alphaStepper.value / 10)
        alphaValue.text = "A : \(alphaStepper.value)"
    }
    
    private func convertRGBToHexColorCode(_ r: Int, _ g: Int, _ b: Int) -> String {
        var hexR = String(r, radix: 16).uppercased()
        var hexG = String(g, radix: 16).uppercased()
        var hexB = String(b, radix: 16).uppercased()
        if r < 16 {
            hexR = "0" + hexR
        }
        if g < 16 {
            hexG = "0" + hexG
        }
        if b < 16 {
            hexB = "0" + hexB
        }
        return "#" + hexR + hexG + hexB
    }
    
    private func disableControlButtons() {
        rgbResetButton.isEnabled = false
        alphaStepper.isEnabled = false
    }
    
    private func enableControlButtons() {
        rgbResetButton.isEnabled = true
        alphaStepper.isEnabled = true
    }
    
    private func setAlphaStepper() {
        alphaStepper.minimumValue = 1
        alphaStepper.maximumValue = 10
        alphaStepper.stepValue = 1
        alphaStepper.autorepeat = true
    }
}


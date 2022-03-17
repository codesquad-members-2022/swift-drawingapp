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
        initAlphaStepper()
    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let touchedCGPoint = sender.location(in: self.view)
        let touchedView = self.view.hitTest(touchedCGPoint, with: nil)
        let touchedPoint = Point(x: touchedCGPoint.x, y: touchedCGPoint.y)
        
        guard let currentView = touchedView else {
            return
        }
        
        let isRectangleAtPoint = plane.isThereARectangle(point: touchedPoint)
        if isRectangleAtPoint, selectedView == nil { // select new Rectangle
            selectShape(currentView)
        }
        if isRectangleAtPoint, selectedView != nil { // select another Rectangle
            selectedView?.layer.borderWidth = 0
            
            selectShape(currentView)
        }
        if !isRectangleAtPoint { // select nothing
            selectedView?.layer.borderWidth = 0
            selectedView = nil
            setDefaultLabel()
            alphaStepper.value = 1.0
            disableControlButtons()
        }
    }
    
    @IBAction func drawRectangle(_ sender: UIButton) {
        let randomX = getRandomXYInScreenBounds().x
        let randomY = getRandomXYInScreenBounds().y
        let randomCGRed = generateRandomRGBA().r
        let randomCGGreen = generateRandomRGBA().g
        let randomCGBlue = generateRandomRGBA().b
        let randomCGAlpha = generateRandomRGBA().a
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
        
        hexValue.text = plane.convertRGBToHexColorCode(Int(randomCGRed), Int(randomCGGreen), Int(randomCGBlue))
        redValue.text = "R : \(randomCGRed)"
        greenValue.text = "G : \(randomCGGreen)"
        blueValue.text = "B : \(randomCGBlue)"
    }
    
    @IBAction func tapAlphaStepper(_ sender: UIStepper) {
        guard let currentView = selectedView else {
            return
        }
    
        guard let currentViewRGBA = currentView.backgroundColor?.rgba else {
            return
        }
        selectedView?.backgroundColor = UIColor(red: currentViewRGBA.red,
                                                green: currentViewRGBA.green,
                                                blue: currentViewRGBA.blue,
                                                alpha: alphaStepper.value / 10)
        setAlphaValueLabel(a: Int(alphaStepper.value))
    }
    
    private func selectShape(_ shape: UIView) {
        guard let rgba = shape.backgroundColor?.rgba else {
            return
        }
        
        let intRGBA = convertRGBAToInteger(r: rgba.red, g: rgba.green, b: rgba.blue, a: rgba.alpha)
        
        selectedView = shape
        shape.layer.borderWidth = 5
        shape.layer.borderColor = UIColor.blue.cgColor
        setHexValueLabel(r: intRGBA.r, g: intRGBA.g, b: intRGBA.b)
        setRGBValueLabel(r: intRGBA.r, g: intRGBA.g, b: intRGBA.b)
        setAlphaValueLabel(a: intRGBA.a)
        setAlphaStepper(value: Double(intRGBA.a))
        enableControlButtons()
    }
    
    private func disableControlButtons() {
        rgbResetButton.isEnabled = false
        alphaStepper.isEnabled = false
    }
    
    private func enableControlButtons() {
        rgbResetButton.isEnabled = true
        alphaStepper.isEnabled = true
    }
    
    private func initAlphaStepper() {
        alphaStepper.minimumValue = 1.0
        alphaStepper.maximumValue = 10.0
        alphaStepper.stepValue = 1.0
        alphaStepper.autorepeat = true
    }
    
    private func setAlphaStepper(value: Double) {
        alphaStepper.value = value
    }
    
    private func setDefaultLabel() {
        hexValue.text = "-"
        redValue.text = "-"
        greenValue.text = "-"
        blueValue.text = "-"
        alphaValue.text = "-"
    }
    
    private func setHexValueLabel(r: Int, g: Int, b: Int) {
        hexValue.text = plane.convertRGBToHexColorCode(Int(r), Int(g), Int(b))
    }
    
    private func setRGBValueLabel(r: Int, g: Int, b: Int) {
        redValue.text = "R : \(r)"
        greenValue.text = "G : \(g)"
        blueValue.text = "B : \(b)"
        
    }
    
    private func setAlphaValueLabel(a: Int) {
        alphaValue.text = "A : \(a)"
    }
    
    private func getRandomXYInScreenBounds() -> (x: Int, y: Int) {
        var result: (x: Int, y: Int) = (0, 0)
        let bounds = UIScreen.main.bounds
        result.x = Int.random(in: 1...Int(bounds.width))
        result.y = Int.random(in: 1...Int(bounds.height))
        return result
    }
    
    private func generateRandomRGBA() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var result: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) = (0.0, 0.0, 0.0, 0.0)
        result.r = CGFloat(Double.random(in: 0...255) / 255)
        result.g = CGFloat(Double.random(in: 0...255) / 255)
        result.b = CGFloat(Double.random(in: 0...255) / 255)
        result.a = CGFloat(Double.random(in: 1...10) / 10)
        return result
    }
    
    private func convertRGBAToInteger(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> (r: Int, g: Int, b: Int, a: Int) {
        var result: (r: Int, g: Int, b: Int, a: Int) = (0, 0, 0, 0)
        result.r = Int(round(r * 255))
        result.g = Int(round(g * 255))
        result.b = Int(round(b * 255))
        result.a = Int(round(a * 10))
        return result
    }
}

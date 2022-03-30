//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    private var plane = Plane()
    private var selectedView: UIView? = nil
    private let shapeFactory = ShapeFactory()
    
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
        guard let selectedRectangle = plane.selectRectangle(x: touchedCGPoint.x, y: touchedCGPoint.y) else {
            print("no Rectangle - unselect")
            unselectView()
            return
        }
        print("select")
    }
    
    @IBAction func drawRectangle(_ sender: UIButton) {
        let rectangleView = convertRectangleToUIView(rectangle: plane.makeNewRandomRectangle())
        self.view.addSubview(rectangleView)
    
    }
    
    @IBAction func resetRGB(_ sender: UIButton) {
        guard let currentView = selectedView else {
            return
        }
        
        let randomRGBA = generateRandomRGBA()
        selectedView?.backgroundColor = UIColor(red: randomRGBA.r,
                                                green: randomRGBA.g,
                                                blue: randomRGBA.b,
                                                alpha: currentView.alpha)
        let randomRGBAInt = convertRGBAToInteger(r: randomRGBA.r, g: randomRGBA.g, b: randomRGBA.b, a: randomRGBA.a)
        setHexValueLabel(r: randomRGBAInt.r, g: randomRGBAInt.g, b: randomRGBAInt.b)
        setRGBValueLabel(r: randomRGBAInt.r, g: randomRGBAInt.g, b: randomRGBAInt.b)
    }
    
    @IBAction func tapAlphaStepper(_ sender: UIStepper) {
        guard let currentViewRGBA = selectedView?.backgroundColor?.rgba else {
            return
        }
        
        selectedView?.backgroundColor = UIColor(red: currentViewRGBA.red,
                                                green: currentViewRGBA.green,
                                                blue: currentViewRGBA.blue,
                                                alpha: alphaStepper.value / 10)
        setAlphaValueLabel(a: Int(alphaStepper.value))
    }
    
    private func selectView(_ view: UIView) {
        if plane.selectedShape != nil { // 기존 selectedShape가 있는데 새로운 view select했을 때
            selectedView?.layer.borderWidth = 0
            
        }
        
        plane.selectedShape = convertUIViewToRectangle(view: view)
        selectedView = view
        
        guard let rgba = view.backgroundColor?.rgba else {
            return
        }
        
        let intRGBA = convertRGBAToInteger(r: rgba.red, g: rgba.green, b: rgba.blue, a: rgba.alpha)
        selectedView?.layer.borderWidth = 5
        selectedView?.layer.borderColor = UIColor.blue.cgColor
        setHexValueLabel(r: intRGBA.r, g: intRGBA.g, b: intRGBA.b)
        setRGBValueLabel(r: intRGBA.r, g: intRGBA.g, b: intRGBA.b)
        setAlphaValueLabel(a: intRGBA.a)
        setAlphaStepper(value: Double(intRGBA.a))
        enableControlButtons()
    }
    
    private func unselectView() {
        selectedView?.layer.borderWidth = 0
        selectedView = nil
        setDefaultLabel()
        alphaStepper.value = 1.0
        disableControlButtons()
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
    
    private func convertRectangleToUIView(rectangle: Rectangle) -> UIView {
        let view = UIView(frame: CGRect(x: rectangle.getPoint().getCurrentX(),
                                        y: rectangle.getPoint().getCurrentY(),
                                        width: rectangle.getSize().getCurrentWidth(),
                                        height: rectangle.getSize().getCurrentHeight()))
        view.backgroundColor = UIColor(red: Double(rectangle.getColor().getRed()) / 255,
                                       green: Double(rectangle.getColor().getGreen()) / 255,
                                       blue: Double(rectangle.getColor().getBlue()) / 255,
                                       alpha: Double(rectangle.getAlpha().rawValue) / 10)
        return view
    }
    
    private func convertUIViewToRectangle(view: UIView) -> Rectangle? {
        guard let rgba = view.backgroundColor?.rgba else {
            return nil
        }
        let intRGBA = convertRGBAToInteger(r: rgba.red, g: rgba.green, b: rgba.blue, a: rgba.alpha)
        let point = Point(x: view.frame.origin.x,
                          y: view.frame.origin.y)
        let size = Size(width: view.frame.size.width,
                        height: view.frame.size.height)
        let color = Color(r: intRGBA.r,
                          g: intRGBA.g,
                          b: intRGBA.b)
        let alpha: Alpha = Alpha(rawValue: intRGBA.a) ?? .one
        return shapeFactory.createRectangle(point: point,
                                                     size: size,
                                                     color: color,
                                                     alpha: alpha)
    }
}

extension UIColor {
    var rgba: (red: Double, green: Double, blue: Double, alpha: Double) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

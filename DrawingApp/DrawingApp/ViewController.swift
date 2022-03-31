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
    
    private var selectedView: UIView? = nil
    
    private var plane = Plane()
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
    
    @IBAction func drawRectangle(_ sender: UIButton) {
        let rectangle = plane.makeNewRandomRectangle()
        let rectangleView = convertRectangleToUIView(rectangle: rectangle)
        self.view.addSubview(rectangleView)
    }
    
    @IBAction func resetRGB(_ sender: UIButton) {
        guard let selectedRectangle = plane.resetSelectedRectangleRandomRGB() else {
            return
        }
        
        let newRectangleView = convertRectangleToUIView(rectangle: selectedRectangle)
        replaceSelectedView(to: newRectangleView)
        
        let color = selectedRectangle.getColor()
        setRGBLabelFromColor(r: color.getRed(), g: color.getGreen(), b: color.getBlue())
        drawRectangleBorderAtPoint(selectedRectangle.getPoint())
    }
    
    @IBAction func tapAlphaStepper(_ sender: UIStepper) {
        let changedAlpha = Alpha(rawValue: Int(alphaStepper.value))!
        guard let selectedRectangle = plane.resetSelectedRectangleAlpha(to: changedAlpha) else {
            return
        }
        
        let newRectangleView = convertRectangleToUIView(rectangle: selectedRectangle)
        replaceSelectedView(to: newRectangleView)
        
        setAlphaValueLabel(a: Int(alphaStepper.value))
        drawRectangleBorderAtPoint(selectedRectangle.getPoint())
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        disselectView()
        
        let touchedCGPoint = sender.location(in: self.view)
        if let selectedRectangle = plane.getRectangleAtPoint(x: touchedCGPoint.x, y: touchedCGPoint.y) {
            if let tappedView = self.view.hitTest(CGPoint(x: selectedRectangle.getPoint().getX(), y: selectedRectangle.getPoint().getY()), with: nil) {
                plane.setSelectedShape(to: selectedRectangle)
                selectedView = tappedView
                selectView(tappedView)
            }
        } else {
            plane.resetSelectedShape()
            selectedView = nil
        }
    }
    
    private func selectView(_ view: UIView) {
        guard let rectangleColor = plane.getSelectedShapeColor(),
              let rectangleAlpha = plane.getSelectedShapeAlpha() else {
            return
        }

        let viewOrigin = view.frame.origin
        drawRectangleBorderAtPoint(Point(x: viewOrigin.x, y: viewOrigin.y))
        setRGBLabelFromColor(r: rectangleColor.getRed(), g: rectangleColor.getGreen(), b: rectangleColor.getBlue())
        setAlphaValueLabel(a: rectangleAlpha.rawValue)
        setAlphaStepper(value: Double(rectangleAlpha.rawValue))
        enableControlButtons()
    }
    
    private func disselectView() {
        selectedView?.layer.borderWidth = 0
        setLabelsDefaultValue()
        alphaStepper.value = 1.0
        disableControlButtons()
    }
    
    private func replaceSelectedView(to view: UIView) {
        selectedView?.removeFromSuperview()
        selectedView = view
        self.view.addSubview(view)
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
    
    private func setLabelsDefaultValue() {
        hexValue.text = "Color code"
        redValue.text = "R : -"
        greenValue.text = "G : -"
        blueValue.text = "B : -"
        alphaValue.text = "A : -"
    }
    
    private func setRGBLabelFromBackgroundColor(r: Double, g: Double, b: Double) {
        let intColor = Color.convertCGValueToInt(red: r, green: g, blue: b)
        setRGBLabelFromColor(r: intColor.red, g: intColor.green, b: intColor.blue)
    }
    
    private func setRGBLabelFromColor(r: Int, g: Int, b: Int) {
        hexValue.text = Color.convertRGBToHexColorCode(r, g, b)
        redValue.text = "R : \(r)"
        greenValue.text = "G : \(g)"
        blueValue.text = "B : \(b)"
    }
    
    private func setAlphaValueLabel(a: Int) {
        alphaValue.text = "A : \(a)"
    }
    
    private func drawRectangleBorderAtPoint(_ point: Point) {
        let rectangleView = self.view.hitTest(CGPoint(x: point.getX(), y: point.getY()), with: nil)
        rectangleView?.layer.borderWidth = 3
        rectangleView?.layer.borderColor = UIColor.blue.cgColor
    }
    
    private func eraseRectangleBorderAtPoint(_ point: Point) {
        let rectangleView = self.view.hitTest(CGPoint(x: point.getX(), y: point.getY()), with: nil)
        rectangleView?.layer.borderWidth = 0
    }
    
    private func convertRectangleToUIView(rectangle: Rectangle) -> UIView {
        let view = UIView(frame: CGRect(x: rectangle.getPoint().getX(),
                                        y: rectangle.getPoint().getY(),
                                        width: rectangle.getSize().getCurrentWidth(),
                                        height: rectangle.getSize().getCurrentHeight()))
        view.backgroundColor = UIColor(red: Double(rectangle.getColor().getRed()) / 255,
                                       green: Double(rectangle.getColor().getGreen()) / 255,
                                       blue: Double(rectangle.getColor().getBlue()) / 255,
                                       alpha: Double(rectangle.getAlpha().rawValue) / 10)
        return view
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

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
        
        selectedView?.removeFromSuperview()
        let newRectangleView = convertRectangleToUIView(rectangle: selectedRectangle)
        selectedView = newRectangleView
        self.view.addSubview(newRectangleView)
        drawRectangleBorderAtPoint(selectedRectangle.getPoint())
        
        let color = selectedRectangle.getColor()
        setRGBValueLabel(r: color.getRed(), g: color.getGreen(), b: color.getBlue())
    }
    
    @IBAction func tapAlphaStepper(_ sender: UIStepper) {
        let changedAlpha = Alpha(rawValue: Int(alphaStepper.value))!
        guard let selectedRectangle = plane.resetSelectedRectangleAlpha(to: changedAlpha) else {
            return
        }
        
        selectedView?.removeFromSuperview()
        let newRectangleView = convertRectangleToUIView(rectangle: selectedRectangle)
        selectedView = newRectangleView
        self.view.addSubview(newRectangleView)
        drawRectangleBorderAtPoint(selectedRectangle.getPoint())
        
        let alpha = selectedRectangle.getAlpha()
        setAlphaValueLabel(a: Int(alphaStepper.value))
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let touchedCGPoint = sender.location(in: self.view)
        
        if let selectedRectangle = plane.getRectangleAtPoint(x: touchedCGPoint.x, y: touchedCGPoint.y) {
            // 터치 지점에 사각형이 있다면
            if let tappedView = self.view.hitTest(CGPoint(x: selectedRectangle.getPoint().getX(), y: selectedRectangle.getPoint().getY()), with: nil) {
                // 사각형 지점의 뷰를 선택
                selectedView = tappedView
                showSelectedView(tappedView)
            }
            // 사각형 지점의 뷰를 모델에 저장
            plane.setSelectedShape(to: selectedRectangle)
        } else {
            // 없다면 선택 해제
            hideSelectedView()
            selectedView = nil
            plane.resetSelectedShape()
        }
    }
    
    private func showSelectedView(_ view: UIView) {
        if plane.isThereSelectedShape() { // 기존 selectedShape가 있는데 새로운 view select했을 때
            if let previousPoint = plane.getSelectedShapePoint() {
                eraseRectangleBorderAtPoint(Point(x: previousPoint.getX(), y: previousPoint.getY()))
            }
        }
        
        guard let rgba = view.backgroundColor?.rgba else {
            return
        }
        let intRGB = convertRGBToInt(r: rgba.red, g: rgba.green, b: rgba.blue)
        let intAlpha = convertAlphaToInt(a: rgba.alpha)
        
        let viewOrigin = view.frame.origin
        drawRectangleBorderAtPoint(Point(x: viewOrigin.x, y: viewOrigin.y))
        
        setRGBValueLabel(r: intRGB.r, g: intRGB.g, b: intRGB.b)
        setAlphaValueLabel(a: intAlpha)
        setAlphaStepper(value: Double(intAlpha))
        enableControlButtons()
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
    
    private func hideSelectedView() {
        selectedView?.layer.borderWidth = 0
        setDefaultLabel()
        alphaStepper.value = 1.0
        disableControlButtons()
    }
    
    private func findViewAtPoint(_ point: Point) -> UIView? {
        return self.view.hitTest(CGPoint(x: point.getX(), y: point.getY()), with: nil)
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

    private func setRGBValueLabel(r: Int, g: Int, b: Int) {
        redValue.text = "R : \(r)"
        greenValue.text = "G : \(g)"
        blueValue.text = "B : \(b)"
        hexValue.text = Color.convertRGBToHexColorCode(Int(r), Int(g), Int(b))
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
    
    private func convertRGBAToUIColor(color: Color, alpha: Alpha) -> UIColor {
        let red = CGFloat(color.getRed() / 255)
        let green = CGFloat(color.getGreen() / 255)
        let blue = CGFloat(color.getBlue() / 255)
        let alpha = CGFloat(alpha.rawValue / 10)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private func convertRGBToInt(r: CGFloat, g: CGFloat, b: CGFloat) -> (r: Int, g: Int, b: Int) {
        var result: (r: Int, g: Int, b: Int) = (0, 0, 0)
        result.r = Int(round(r * 255))
        result.g = Int(round(g * 255))
        result.b = Int(round(b * 255))
        return result
    }
    
    private func convertAlphaToInt(a: CGFloat) -> Int {
        return Int(round(a * 10))
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
    
    private func convertUIViewToRectangle(view: UIView) -> Rectangle? {
        guard let rgba = view.backgroundColor?.rgba else {
            return nil
        }
        let intRGB = convertRGBToInt(r: rgba.red, g: rgba.green, b: rgba.blue)
        let intAlpha = convertAlphaToInt(a: rgba.alpha)
        let point = Point(x: view.frame.origin.x,
                          y: view.frame.origin.y)
        let size = Size(width: view.frame.size.width,
                        height: view.frame.size.height)
        let color = Color(r: intRGB.r,
                          g: intRGB.g,
                          b: intRGB.b)
        let alpha: Alpha = Alpha(rawValue: intAlpha) ?? .one
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

//
//  MainScreenViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/06.
//

import UIKit

protocol MainScreenDelegate {
    func addRectangle(using property: RectangleProperty, index: Int)
    func admitColor(to view: Rectangle, using color: RectRGBColor, alpha: Double)
    func admitAlpha(to view: Rectangle, using value: Float)
    func getScreenViewProperty() -> FactoryProperties
}

typealias MainScreenTapType = MainScreenViewController.TapType

class MainScreenViewController: UIViewController, MainScreenDelegate {
    
    var delegate: RectangleViewTapDelegate?
    private var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapHandler(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func addRectangle(using property: RectangleProperty, index: Int) {
        let rect = Rectangle(model: property, index: index)
        let rectTapGesture = UITapGestureRecognizer(target: rect, action: #selector(rect.rectTapHandler(_:)))
        rect.addGestureRecognizer(rectTapGesture)
        rectTapGesture.delegate = self
        self.view.addSubview(rect)
    }
    
    func admitColor(to rect: Rectangle, using color: RectRGBColor, alpha: Double) {
        guard view.subviews.contains(where: {($0 as? Rectangle) == rect}) else { return }
        rect.setBackgroundColor(using: color, alpha: alpha)
    }
    
    func admitAlpha(to rect: Rectangle, using value: Float) {
        guard view.subviews.contains(where: {($0 as? Rectangle) == rect}) else { return }
        rect.setValue(alpha: value)
    }
    
    func getScreenViewProperty() -> FactoryProperties {
        let frame = view.frame
        return FactoryProperties(maxX: (frame.width - 150), maxY: (frame.height - 120), width: 150, height: 120)
    }
    
    @objc func backgroundTapHandler(_ recognizer: UITapGestureRecognizer) { }
    
    enum TapType {
        case background
        case rectangle
    }
}

extension MainScreenViewController: UIGestureRecognizerDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let rect = touches.first?.view as? Rectangle {
            rect.isSelected = true
            delegate?.changeCurrentSelected(rect, parent: parent, typeOf: .rectangle)
        } else {
            delegate?.changeCurrentSelected(nil, parent: parent, typeOf: .background)
        }
    }
}

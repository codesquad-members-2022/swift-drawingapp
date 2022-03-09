//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties for View
    @IBOutlet weak var controlPanelView: ControlPanelView!
    @IBOutlet weak var planeView: PlaneView!
    
    // MARK: - Property for Model
    private var plane = Plane()
    private var rectangleMap = [Rectangle: RectangleView]()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDelegate()
        self.setObservers()
    }
    
    // MARK: - UI Configuration Methods
    func configureDelegate() {
        self.planeView.delegate = self
        self.controlPanelView.delegate = self
    }
    
    func setObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.rectangleDataDidCreated), name: .RectangleDataDidCreated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.rectangleDataDidChanged), name: .RectangleDataDidUpdated, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.planeDidDidSelectItem), name: .PlaneDidSelectItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.planeDidDidUnselectItem), name: .PlaneDidUnselectItem, object: nil)
    }
}

// MARK: - PlaneView To ViewController
extension ViewController: PlaneViewDelegate {
    func planeViewDidTapped() {
        self.plane.unselectItem()
    }
    
    func planeViewDidPressRectangleAddButton() {
        let rectangle = RectangleFactory.makeRandomRectangle()
        plane.append(item: rectangle)
    }
}

// MARK: - ControlPanelView To ViewController
extension ViewController: ControlPanelViewDelegate {
    func controlPanelDidPressColorButton() {
        guard let rectangle = self.plane.currentItem else { return }
        guard let color = UIColor.random().convert(using: Color.self) else { return }
        
        rectangle.setBackgroundColor(color)
    }
    
    func controlPanelDidMoveAlphaSlider(_ sender: UISlider) {
        guard let rectangle = self.plane.currentItem else { return }
        guard let alpha = Alpha(rawValue: Int(sender.value)) else { return }
        
        rectangle.setAlpha(alpha)
    }
}

// MARK: - RectangleView To ViewController
extension ViewController {
    @objc func handleOnTapRectangleView(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        guard let rectangleView = sender.view else { return }
        
        let point = rectangleView.frame.origin.convert(using: Point.self)
        
        guard let rectangle = self.plane.findItemBy(point: point) else { return }
        
        self.plane.selectItem(id: rectangle.id)
    }
}

// MARK: - Rectangle Model To ViewController
extension ViewController {
    @objc func rectangleDataDidCreated(_ notification: Notification) {
        guard let rectangle = notification.object as? Rectangle else { return }
        
        let rectangleView = RectangleView(with: rectangle)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleOnTapRectangleView))
        
        rectangleView.addGestureRecognizer(tap)
        rectangleView.accessibilityIdentifier = rectangle.id
        
        self.planeView.addSubview(rectangleView)
        self.rectangleMap.updateValue(rectangleView, forKey: rectangle)
    }
    
    @objc func rectangleDataDidChanged(_ notification: Notification) {
        
    }
}

// MARK: - Plane Model to ViewController
extension ViewController {
    @objc func planeDidDidSelectItem(_ notification: Notification) {
        guard let rectangle = notification.userInfo?[Plane.NotificationKey.select] as? Rectangle else { return }
        guard let rectangleView = self.rectangleMap[rectangle] else { return }

        rectangleView.setBorder(width: 2, color: .blue)
    }
    
    @objc func planeDidDidUnselectItem(_ notification: Notification) {
        guard let rectangle = notification.userInfo?[Plane.NotificationKey.unselect] as? Rectangle else { return }
        guard let rectangleView = self.rectangleMap[rectangle] else { return }
        
        rectangleView.removeBorder()
    }
}

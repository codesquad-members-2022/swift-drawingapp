//
//  MainViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit

final class MainViewController: UIViewController {
    
    static let addButtonPushed = Notification.Name.init(rawValue: "addButtonPushed")
    static let colorButtonPushed = Notification.Name.init(rawValue: "colorButtonPushed")
    static let sliderMoved = Notification.Name.init(rawValue: "sliderMoved")
    
    @IBOutlet weak var buttonSetRandomColor: UIButton!
    @IBOutlet weak var sliderSetAlpha: UISlider!
    
    private var defaultButtonColor: UIColor!
    
    private let plane = Plane()
    private var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultButtonColor = buttonSetRandomColor.backgroundColor
        
        NotificationCenter.default.addObserver(
            forName: MainScreenViewController.rectangleViewTouched,
            object: plane,
            queue: .current
        ) { [weak self] noti in
            guard let self = self else { return }
            
            self.currentIndex = noti.userInfo?[Plane.PostKey.index] as? Int
            OperationQueue.main.addOperation {
                self.processRectangleTouchedObserve((noti.userInfo as? [Plane.PostKey: Any]))
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: Plane.alphaDidChanged,
            object: plane,
            queue: .current
        ) { [weak self] noti in
            guard let self = self else { return }
            
            OperationQueue.main.addOperation {
                self.processRectangleTouchedObserve((noti.userInfo as? [Plane.PostKey: Any]))
            }
        }
    }
    
    private func processRectangleTouchedObserve(_ userInfo: [Plane.PostKey: Any]?) {
        guard let model = userInfo?[.model] as? RectangleProperty else {
            buttonSetRandomColor.backgroundColor = self.defaultButtonColor
            sliderSetAlpha.setValue(0, animated: true)
            return
        }
        
        buttonSetRandomColor.backgroundColor = model.rgbValue.getColor(alpha: model.alpha)
        sliderSetAlpha.setValue(Float(model.alpha), animated: true)
    }
    
    @IBAction func buttonForAddTouchUpInside(_ sender: UIButton) {
        plane.addRectangle()
    }
    
    @IBAction func buttonAdmitColorTouchUpInside(_ sender: UIButton) {
        guard
            let index = currentIndex,
            let color = plane.resetRandomColor(at: index)
        else {
            return
        }
        
        buttonSetRandomColor.backgroundColor = color.getColor(alpha: Double(sliderSetAlpha.value))
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        guard let index = currentIndex else { return }
        
        sender.value = round(sender.value)
        plane.setAlpha(value: sender.value, at: index)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainScreenViewController {
            plane.screenDelegate = vc
            vc.delegate = plane
        }
    }
}

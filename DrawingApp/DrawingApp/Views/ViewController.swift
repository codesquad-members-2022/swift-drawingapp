//
//  ViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var buttonSetRandomColor: UIButton!
    @IBOutlet weak var sliderSetAlpha: UISlider!
    
    private var defaultButtonColor: UIColor!
    
    private let plane = Plane()
    private var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultButtonColor = buttonSetRandomColor.backgroundColor
        observeMainScreenTouched(using: { [weak self] noti in
            guard let self = self else { return }
            
            self.currentIndex = noti.userInfo?["index"] as? Int
            
            let button = self.buttonSetRandomColor
            let slider = self.sliderSetAlpha
            
            guard let property = noti.object as? RectangleProperty else {
                button?.backgroundColor = self.defaultButtonColor
                slider?.setValue(0, animated: true)
                return
            }
            
            button?.backgroundColor = property.rgbValue.getColor(alpha: property.alpha)
            slider?.setValue(Float(property.alpha), animated: true)
        })
    }
    
    @IBAction func buttonForAddTouchUpInside(_ sender: UIButton) {
        plane.addRectangle()
    }
    
    @IBAction func buttonAdmitColorTouchUpInside(_ sender: UIButton) {
        guard
            let index = currentIndex,
            let color = plane.setRandomColor(at: index)
        else {
            return
        }
        
        buttonSetRandomColor.backgroundColor = color.getColor(alpha: Double(sliderSetAlpha.value))
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        guard let index = currentIndex else { return }
        
        sender.value = round(sender.value)
        plane.setAlpha(value: sender.value, at: index)
        
        let color = buttonSetRandomColor.backgroundColor
        buttonSetRandomColor.backgroundColor =
            color?.withAlphaComponent(Double(sender.value)/RectRGBColor.maxAlpha)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainScreenViewController {
            plane.screenDelegate = vc
            vc.delegate = plane
        }
    }
}

//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    @IBOutlet weak var rgbValue: UILabel!
    
    @IBOutlet weak var alphaValue: UILabel!
    //    @IBOutlet weak var tappableView: UIView! {
//        didSet {
//            tappableView.backgroundColor = .blue
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap Gesture Recognizer 초기화
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        
        // Tap Gesture Recognizer를 뷰 전체에 추가
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("didTapView", sender)
    }
    
    @IBAction func resetRGB(_ sender: Any) {
    }
    
    @IBAction func tapAlphaStepper(_ sender: Any) {
    }
}


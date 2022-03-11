//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var tappableView: UIView! {
        didSet {
            tappableView.backgroundColor = .blue
        }
    }
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        print("didTapView", sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}


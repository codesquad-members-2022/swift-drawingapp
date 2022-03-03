//
//  PanelViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import UIKit

class PanelViewController: UIViewController {
    private var containerVC: DrawingSplitViewController?
    
    @IBOutlet weak var colorButton: UIButton!
    
    @IBAction func ColorButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var AlphaLabel: UILabel!
    
    @IBAction func SliderChanged(_ sender: UISlider) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerVC = splitViewController as? DrawingSplitViewController
        containerVC?.plane.selectionDelgate = self
        
    }
}

extension PanelViewController: PlaneSelectionDelegate {
    func didSelectViewModels(_ selected: ViewModel?) {
        guard let selected = selected else { return }
        guard let colorMutableViewModel = selected as? ColorMutable else { return }
        let selectedColor = colorMutableViewModel.uiColor
        let selectedColorHex = selectedColor.toHex() ?? ""
        colorButton.tintColor = colorMutableViewModel.uiColor
        
        colorButton.setTitle(selectedColorHex, for: .normal)
        if selectedColor.isDark {
            colorButton.setTitleColor(.black, for: .normal)
        } else {
            colorButton.setTitleColor(.white, for: .normal)
        }
        
    }
}


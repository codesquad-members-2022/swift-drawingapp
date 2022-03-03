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
    
    @IBOutlet weak var alphaSlider: UISlider!
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
        
        if let colorMutableViewModel = selected as? ColorMutable {
            displayColor(colorMutableViewModel)
        } else {
            colorButton.isEnabled = false
        }
        
        if let alphaMutableViewModel = selected as? AlphaMutable {
            displayAlpha(alphaMutableViewModel)
        } else {
            alphaSlider.isEnabled = false
            return
        }
    }
    
    private func displayColor(_ selected: ColorMutable) {
        let selectedColor = selected.uiColor
        colorButton.tintColor = selected.uiColor
        
        let selectedColorHex = selectedColor.toHex() ?? ""
        colorButton.setTitle(selectedColorHex, for: .normal)
        
        let visibleColor = selectedColor.isDark ? UIColor.white : UIColor.black
        colorButton.setTitleColor(visibleColor, for: .normal)
    }
    
    private func displayAlpha(_ selected: AlphaMutable) {
        let selectedAlpha = selected.alpha
        alphaSlider.value = selectedAlpha.value
        
        let selectedAlphaString = "\(selectedAlpha.value)"
        AlphaLabel.text = selectedAlphaString
    }
}


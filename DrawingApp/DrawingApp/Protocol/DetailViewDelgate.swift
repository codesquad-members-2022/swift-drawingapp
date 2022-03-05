//
//  DetailViewDelgate.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/05.
//

import UIKit

protocol DetailViewDelgate:AnyObject {
    func sliderViewEndEditing(sender:UISlider)
    func colorButtonTouched(sender:UIButton)
}

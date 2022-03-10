//
//  RectangleViewDelegate.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/10.
//

import Foundation
import UIKit

protocol RectangleViewDelegate {
    
    func touchedAddRectangleButton()
    func touchedCanvas(at point: CGPoint)
}

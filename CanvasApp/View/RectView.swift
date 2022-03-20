//
//  RectView.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/15.
//

import UIKit

protocol ColorfulView {
    func changeColor(with color: CGColor)
}

class RectView : UIView, ColorfulView {
    func changeColor(with color: CGColor) {
        self.backgroundColor = UIColor(cgColor: color)
    }
}

typealias PictureView = UIImageView

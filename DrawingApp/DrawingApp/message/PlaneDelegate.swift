//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/04.
//

import Foundation

protocol PlaneDelegate{
    func didChangedColor(id: String, colorRGB: ColorRGB)
    func didSelectedTarget(id: String, colorRGB: ColorRGB)
    func deSelectedTarget()
    func didUpdateAlpha(id: String, alpha: Double)
}

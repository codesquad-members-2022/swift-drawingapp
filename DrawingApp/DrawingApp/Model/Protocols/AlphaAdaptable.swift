//
//  AlphaAdaptable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/18.
//

import Foundation

protocol AlphaAdaptable {
    var alpha: Alpha { get }
    func setAlpha(_ alpha: Alpha)
}

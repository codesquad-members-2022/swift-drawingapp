//
//  BackgroundAdaptable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/18.
//

import Foundation

protocol BackgroundAdaptable {
    var backgroundColor: Color { get }
    func setBackgroundColor(_ color: Color)
}

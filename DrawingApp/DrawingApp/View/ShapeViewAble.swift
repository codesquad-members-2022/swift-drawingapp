//
//  ShapeView.swift
//  DrawingApp
//
//  Created by dale on 2022/03/16.
//

import UIKit

protocol AlphaMutable {
    func setAlpha(alpha: Alpha)
}

protocol BorderMutable{
    func borderVisible(_ enable: Bool)
}

protocol ShapeViewAble: AlphaMutable, BorderMutable {
}

//
//  CGRect+Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/09.
//

import UIKit

extension CGRect: RectangleBuildable {
    init(with rectangle: Shapable) {
        self.init(x: rectangle.origin.x, y: rectangle.origin.y, width: rectangle.size.width, height: rectangle.size.height)
    }
}

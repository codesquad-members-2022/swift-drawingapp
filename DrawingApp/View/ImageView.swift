//
//  ImageView.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/08.
//

import Foundation
import UIKit

final class ImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

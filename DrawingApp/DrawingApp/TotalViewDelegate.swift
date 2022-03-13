//
//  TotalViewDelegate.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/11.
//

import Foundation
import UIKit

protocol TotalViewDelegate {
    /// VC에 TotalView가 터치되었다고 알려줌! (TotalView -> (VC) -> VC가 팩토리로 사각형 만들어서 사각형 리턴)
    func totalViewDidTouched(_ totalView: TotalView) -> Rectangle?
}

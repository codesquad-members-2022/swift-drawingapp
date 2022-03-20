//
//  TopApplication.swift
//  CanvasApp
//
//  Created by JK on 2022/03/20.
//

import UIKit

class TopApplication : UIApplication {
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
    }
    
    override func sendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
        return super.sendAction(action, to: target, from: sender, for: event)
    }
}

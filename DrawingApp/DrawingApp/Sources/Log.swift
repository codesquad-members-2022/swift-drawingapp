//
//  Log.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/14.
//

import Foundation
import OSLog

extension OSLog {
    static func log(message: String) {
        os_log("\(message)")
    }
}

//
//  Log.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/03.
//

import Foundation
import OSLog

class Log {
    enum LogError: Error {
        case config
    }
    
    private var bundleIdentifier: String?
    private var osLog: OSLog?
    static let shared = Log()
    
    private init() {
        bundleIdentifier = Bundle.main.bundleIdentifier
    }
    
    func config() throws {
        guard let subsystem = bundleIdentifier else {
            throw LogError.config
        }
        self.osLog = OSLog(subsystem: subsystem, category: "")
    }
    
    func print(logLevel: OSLogType, message: String) {
        os_log(logLevel, log: self.osLog ?? .default, "\(message)")
    }
}

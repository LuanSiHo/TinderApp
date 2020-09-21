//
//  String_Extension.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

extension String {
    
    // add base domain before endpoint
    func url() -> String {
        var temp: String = "/"
        if self.hasPrefix("/") {
            temp = ""
        }
        return Config.domain + temp + self
    }
}

// MARK: - Date format
extension String {
    func convertToDateWithFormmatter(_ dateFormat: String = DateFormatName.fullDate) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        
        return formatter.date(from: self) ?? Date()
    }
}

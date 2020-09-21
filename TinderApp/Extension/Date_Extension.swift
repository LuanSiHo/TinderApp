//
//  Date_Extension.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

extension Date {
    func convertToCustomFormatter(_ dateFormat: String = DateFormatName.fullDate) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: self)
    }
}

//
//  CustomTransform.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class BirthdayTransform: TransformType {
    typealias Object = String
    typealias JSON = String
    
    init() {}
    func transformFromJSON(_ value: Any?) -> String? {
        if let anyValue = value as? String {
            let date = anyValue.convertToDateWithFormmatter(DateFormatName.ISO8601FormatDate)
            let formattedDateString = date.convertToCustomFormatter(DateFormatName.fullDate)
            return formattedDateString
        }
        return nil
    }
    
    func transformToJSON(_ value: String?) -> String? {
        if let anyValue = value {
            return anyValue
        }
        return nil
    }
}

//
//  StreetModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class StreetModel: BaseModel {
    @objc dynamic var addressNumber: Int = 0
    @objc dynamic var streetName: String = ""
    
    override func mapping(map: Map) {
        addressNumber       <- map["number"]
        streetName          <- map["name"]
    }
}

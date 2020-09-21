//
//  UserListParam.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class UserListParam: BaseModel {
    var numberOfResult: Int = 0
    
    override func mapping(map: Map) {
        numberOfResult      <- map["results"]
    }
}

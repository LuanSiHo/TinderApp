//
//  NameModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class NameModel: BaseModel {
    var title: String = ""
    var firstName: String = ""
    var lastName: String = ""
    
    lazy var fullName: String = {
        return self.firstName + " " + self.lastName
    }()
    
    override func mapping(map: Map) {
        title       <- map["title"]
        firstName   <- map["first"]
        lastName    <- map["last"]
    }
}

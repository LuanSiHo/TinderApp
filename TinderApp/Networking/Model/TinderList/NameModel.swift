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
    @objc dynamic var title: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    
    lazy var fullName: String = {
        return self.firstName + " " + self.lastName
    }()
    
    override func mapping(map: Map) {
        title       <- map["title"]
        firstName   <- map["first"]
        lastName    <- map["last"]
    }
    
    override class func ignoredProperties() -> [String] {
        return ["fullName"]
    }
}

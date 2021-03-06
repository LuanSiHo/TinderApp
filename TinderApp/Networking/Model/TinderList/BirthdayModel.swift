//
//  BirthdayModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class BirthdayModel: BaseModel {
    @objc dynamic var date: String = ""
    
    override func mapping(map: Map) {
        date        <- (map["date"], BirthdayTransform())
    }
}

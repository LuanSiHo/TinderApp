//
//  BaseModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class BaseModel: Object, Mappable {
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
    }
}

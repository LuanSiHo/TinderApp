//
//  BaseModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel: NSObject, Mappable {
    required init?(map: Map) {}
    override init() {}
    
    func mapping(map: Map) {}
}

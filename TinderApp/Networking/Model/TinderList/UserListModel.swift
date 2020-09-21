//
//  UserListModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class UserListModel: BaseModel {
    var items: [UserModel] = []
    override func mapping(map: Map) {
        items       <- map["results"]
    }
}

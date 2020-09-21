//
//  UserModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel: BaseModel {
    var name: NameModel?
    var birthday: BirthdayModel?
    var location: LocationModel?
    var phoneNumber: String = ""
    var avatarImage: AvatarImageModel?

    override func mapping(map: Map) {
        name        <- map["name"]
        birthday    <- map["dob"]
        location    <- map["location"]
        phoneNumber <- map["phone"]
        avatarImage <- map["picture"]
    }
}

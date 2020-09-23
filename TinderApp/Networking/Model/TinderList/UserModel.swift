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
    @objc dynamic var name: NameModel?
    @objc dynamic var birthday: BirthdayModel?
    @objc dynamic var location: LocationModel?
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var avatarImage: AvatarImageModel?

    override func mapping(map: Map) {
        name        <- map["name"]
        birthday    <- map["dob"]
        location    <- map["location"]
        phoneNumber <- map["phone"]
        avatarImage <- map["picture"]
    }
    
    override class func primaryKey() -> String? {
        return "phoneNumber"
    }
}

//
//  AvatarModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class AvatarImageModel: BaseModel {
    var largeImage: String = ""
    var mediumImage: String = ""
    var thumbnailImage: String = ""
    
    override func mapping(map: Map) {
        largeImage      <- map["large"]
        mediumImage     <- map["medium"]
        thumbnailImage  <- map["thumbnail"]
    }
}

//
//  LocationModel.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import ObjectMapper

class LocationModel: BaseModel {
    @objc dynamic var street: StreetModel?
    @objc dynamic var city: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var country: String = ""
    
    lazy var detailAddress: String = {
        var detailAddress: String = ""
        if let addressNumber = street?.addressNumber {
            detailAddress.append("\(addressNumber)")
        }
        let streetName = street?.streetName ?? ""
        detailAddress.append(", \(streetName)")
        
        detailAddress.append(", \(city)")
        detailAddress.append(", \(state)")
        detailAddress.append(", \(country)")
        return detailAddress
    }()
    
    override static func ignoredProperties() -> [String] {
        return ["detailAddress"]
    }
    
    override func mapping(map: Map) {
        street          <- map["street"]
        city            <- map["city"]
        state           <- map["state"]
        country         <- map["country"]
    }
}

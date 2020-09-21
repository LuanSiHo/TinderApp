//
//  TinderListUri.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

enum TinderListUriType: String {
    case user = "api"
    case productDetail = "/{product_id}/detail"
     
    var uri: String {
        switch self {
        case .user:                     return TinderListUriType.user.rawValue
        case .productDetail:            return TinderListUriType.productDetail.rawValue
        }
    }
    
    func with(productId: String) -> String {
        let str = self.uri
        return str.replacingOccurrences(of: "{product_id}", with: productId)
    }
}

//
//  NetworkRequest.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkRequest {

    public var method               : Alamofire.HTTPMethod
    public var url                  : String
    public var parameters           : [String: Any]?
    public var headers              : HTTPHeaders?
    public var is_multipart         : Bool = false
    public var timeOutRequest       : Double = 30.0
    public var timeOutResponse      : Double = 30.0

    public init(method: Alamofire.HTTPMethod, url: String) {
        self.method = method
        self.url = url
    }

    public var onSuccess:((_ result: Any)->())?
    public var onFailure:((_ error: ErrorModel)->())?
}

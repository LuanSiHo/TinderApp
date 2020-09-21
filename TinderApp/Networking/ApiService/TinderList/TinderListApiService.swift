//
//  TinderListApiService.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

class TinderListApiService<Delegate: BaseProtocol>: BaseApiService<Delegate> {
    func loadUserList(param: UserListParam, completionHandler: @escaping (ApiResponseData<[String: Any]>) -> Void) {
        
        let url = TinderListUriType.user.uri.url()
        let request = NetworkRequest(method: .get, url: url)
        request.parameters = param.toJSON()
        
        request.onSuccess = { (responseJson) in
            let jsonResponse = responseJson as? [String: Any] ?? [:]
            completionHandler(.success(jsonResponse))
        }
        
        request.onFailure = { (error) in
            completionHandler(.failure(error))
        }
        
        alamofireManager.request(networkRequest: request)
    }
}

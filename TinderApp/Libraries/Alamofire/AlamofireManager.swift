//
//  AlamofireManager.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import UIKit
import Alamofire

public class AlamofireManager: NSObject {
    
    public lazy var shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest  = 30
        configuration.timeoutIntervalForResource = 30
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()

    public var headers: HTTPHeaders {
        var defaultHeaders = SessionManager.defaultHTTPHeaders
        defaultHeaders["Content-Type"]  = "application/json"
        return defaultHeaders
    }
    
    public static func checkNetworkAvailable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    public func request(networkRequest: NetworkRequest) {
        // update time out
        setSharedInstacne(rq: networkRequest)
        
        // headers
        var headers = self.headers
        if let customHeaders = networkRequest.headers, !customHeaders.isEmpty {
            headers = headers.merging(customHeaders) { $1 }
        }
        
        var encoding: ParameterEncoding = JSONEncoding()
        
        if networkRequest.method == .get {
            encoding = Alamofire.URLEncoding.default
        }
        
        if networkRequest.method == .post {
            if networkRequest.is_multipart {
                encoding = URLEncoding.queryString
            }
        }
        
        let request = shared.request(networkRequest.url,
                                     method: networkRequest.method,
                                     parameters: networkRequest.parameters,
                                     encoding: encoding,
                                     headers: headers).debugLog()
        
        request.responseJSON { (response) in
            switch response.result {
            case .success(let responseJson):
                networkRequest.onSuccess?(responseJson)
                break
            case .failure(let error):
                let statusCode = response.response?.statusCode ?? 0
                let message = error.localizedDescription
                let description = response.response.debugDescription
                networkRequest.onFailure?(ErrorModel(code: statusCode, message: message, description: description))
                break
            }
        }
    }
    
    // MARK: private function
    private func setSharedInstacne(rq: NetworkRequest) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = rq.timeOutRequest
        configuration.timeoutIntervalForResource = rq.timeOutResponse
        
        shared = Alamofire.SessionManager(configuration: configuration)
    }
}

// MARK: - create curl for request
extension DataRequest {
    public func debugLog() -> Self {
        print("--------------------------")
        debugPrint(self)
        print("--------------------------")
        return self
    }
}

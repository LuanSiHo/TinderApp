//
//  BaseApiService.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

class BaseApiService<Delegate> where Delegate: BaseProtocol {
    
    let alamofireManager: AlamofireManager = AlamofireManager()
    weak var delegate: Delegate?
    
    init(delegate: Delegate) {
        self.delegate = delegate
    }
    
    func loadData(completionHandler: @escaping (ApiResponseData<[String: Any]>) -> Void) {}
}

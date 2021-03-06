//
//  ErrorType.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/20/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

public enum ErrorType {
    case defaultError
    case noInternetError
    case customeError(error: ErrorModel)
}

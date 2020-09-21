//
//  ErrorView.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/21/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation

class ErrorView {
    
    static let shared = ErrorView()
    private init() {}
    private var alert: UIAlertController?
    
    func showError(type: ErrorType) {
        let error = getErrorMessageFrom(type: type)
        alert = UIAlertController(title: error.0, message: error.1, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.alert?.dismiss(animated: true, completion: nil)
        }
        alert?.addAction(okAction)
        guard let app: AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        app.window?.rootViewController?.present(alert!, animated: true, completion: nil)
    }
    
    private func getErrorMessageFrom(type: ErrorType) -> (String, String) {
        switch type {
        case .defaultError:
            return ("", DefineString.defaultErrorMessage)
        case .noInternetError:
            return ("", DefineString.noInternetErrorMessage)
        case .customeError(let error):
            return ("", "\(error.message)")
        }
    }
}

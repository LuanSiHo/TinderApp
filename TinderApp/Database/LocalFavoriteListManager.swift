//
//  FavoriteListManager.swift
//  TinderApp
//
//  Created by Ho Si Luan on 9/22/20.
//  Copyright © 2020 Ho Si Luan. All rights reserved.
//

import Foundation
import RealmSwift

protocol LocalManager {
    func getAll() -> [Any]
    func removeAll() throws
}

class LocalFavoriteListManager: LocalManager {
    static let shared = LocalFavoriteListManager()
    private init() {}
    
    private var realm: Realm? = try? Realm()
    
    func add(user: UserModel) throws {
        do {
            try realm?.write {
                realm?.add(user.detached())
            }
        } catch let error {
            throw error
        }
    }
    
    func getAll() -> [Any] {
        return realm?.objects(UserModel.self).toArray() ?? []
    }
    
    func removeAll() throws {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch let error {
            throw error
        }
    }
}


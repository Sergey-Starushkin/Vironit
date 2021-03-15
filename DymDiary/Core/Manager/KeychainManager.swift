//
//  KeychainManager.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 1.02.21.
//

import Foundation
import KeychainAccess

class KeychainManager {
    
    static let shared = KeychainManager()
    
    let keychain = Keychain(service: KeychainKey.service.value).synchronizable(true)
    
    private init() {}
    
    func deleteKeychainData() {
        KeychainKey.allCases.forEach({ keychain[$0.value] = nil })
    }

    func save(_ value: String, key: KeychainKey) {
        do {
            try keychain.set(value, key: key.value)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func save(_ value: Bool, key: KeychainKey) {
        do {
            try keychain.set("\(value)", key: key.value)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func get(key: KeychainKey) -> String {
        guard let value = try? keychain.getString(key.value) else { return "" }
        return value
    }
    
    func getBool(key: KeychainKey) -> Bool? {
        guard let valueString = try? keychain.getString(key.value) else { return false }
        let resBool = Bool(valueString)
        return resBool
    }
}

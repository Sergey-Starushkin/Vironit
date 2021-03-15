//
//  KeychainKey.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 1.02.21.
//

import UIKit

enum KeychainKey: String, CaseIterable {
    case service = "com.dymdiary"
    case isAuth = "isAuth"
    
    // - User Info
    case name = "name"
    case id = "id"
    case userPhoto = "photo"
    var value: String {
        self.rawValue
    }
}

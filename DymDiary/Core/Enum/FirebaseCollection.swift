//
//  FirebaseCollection.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 14.02.21.
//

import Foundation

enum FirebaseCollection: String {
    case userData = "UserData"
    case history = "history"
    
    var value: String {
        return self.rawValue
    }
}

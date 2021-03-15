//
//  UserModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 6.02.21.
//

import Foundation

class UserDataModel: NSObject {
    
    var age = 0
    var height = 0.0
    var weignt = 0.0
    var birthday = Date()
    var gender: Gender = .other
    var photo = ""
}

//
//  UserModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 24.02.21.
//

import RealmSwift

class UserModel: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var birthday = 0
    @objc dynamic var height = 0.0
    @objc dynamic var weight = 0.0
    @objc dynamic var photoUrl = ""
    @objc dynamic var gender = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, photoUrl, age, birthday, height, weight, gender
    }
    
    required convenience init(data: [String:Any]) throws {
        self.init()
        id = data[CodingKeys.id.rawValue] as? String ?? "1"
        name = data[CodingKeys.name.rawValue] as? String ?? ""
        age = data[CodingKeys.age.rawValue] as? Int ?? 0
        birthday = data[CodingKeys.birthday.rawValue] as? Int ?? 0
        height = data[CodingKeys.height.rawValue] as? Double ?? 0.0
        weight = data[CodingKeys.weight.rawValue] as? Double ?? 0.0
        photoUrl = data[CodingKeys.photoUrl.rawValue] as? String ?? ""
        gender = data[CodingKeys.gender.rawValue] as? String ?? ""
        
    }
}

//
//  ExcersicesTypesModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 26.02.21.
//

import RealmSwift

class ExcersicesTypesModel: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    required convenience init(data: [String:Any]) throws {
        self.init()
        id = data[CodingKeys.id.rawValue] as? String ?? "0"
        name = data[CodingKeys.name.rawValue] as? String ?? ""
    }
}

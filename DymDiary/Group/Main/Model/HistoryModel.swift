//
//  HistoryModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 11.03.21.
//

import RealmSwift

class HistoryModel: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var userId = ""
    @objc dynamic var programId = ""
    @objc dynamic var day = ""
    @objc dynamic var month = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, userId = "user_id", programId = "program_id", day, month = "mounth"
    }
    
    required convenience init(data: [String:Any]) throws {
        self.init()
        id = data[CodingKeys.id.rawValue] as? String ?? "0"
        userId = data[CodingKeys.userId.rawValue] as? String ?? "0"
        programId = data[CodingKeys.programId.rawValue] as? String ?? ""
        day = data[CodingKeys.day.rawValue] as? String ?? ""
        month = data[CodingKeys.month.rawValue] as? String ?? ""
    }
}

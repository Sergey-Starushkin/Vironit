//
//  ExcercisesTimeObject.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 5.03.21.
//

import RealmSwift

class ExcercisesApproachObject: Object, Codable {
    
    @objc dynamic var id = 0
    @objc dynamic var repsNumber = 0
    @objc dynamic var restTime = 0
    @objc dynamic var setsNumber = 0
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "exercise_id", repsNumber = "reps_number", restTime = "rest_time", setsNumber = "sets_number"
    }
    
    required convenience init(data: [String:Any]) {
        self.init()
        id = data[CodingKeys.id.rawValue] as? Int ?? 0
        repsNumber = data[CodingKeys.repsNumber.rawValue] as? Int ?? 0
        setsNumber = data[CodingKeys.setsNumber.rawValue] as? Int ?? 0
        restTime = data[CodingKeys.restTime.rawValue] as? Int ?? 0
    }
}

//
//  StaticTimeProgramm.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 7.03.21.
//

import RealmSwift

import RealmSwift

class StaticTimeModel: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    @objc dynamic var rest_between_rounds = 0
    @objc dynamic var rest_time = 0
    @objc dynamic var rounds = 0
    @objc dynamic var work_time = 0

    dynamic var exercises = List<ExcercisesTimeObject>()

    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, photo, rest_between_rounds, exercises = "exercise_id", rest_time, rounds, work_time
    }
    
    required convenience init(data: [String:Any]) throws {
        self.init()
        id = data[CodingKeys.id.rawValue] as? Int ?? 0
        name = data[CodingKeys.name.rawValue] as? String ?? ""
        photo = data[CodingKeys.photo.rawValue] as? String ?? ""
        rest_between_rounds = data[CodingKeys.rest_between_rounds.rawValue] as? Int ?? 0
        rest_time = data[CodingKeys.rest_time.rawValue] as? Int ?? 0
        rounds = data[CodingKeys.rounds.rawValue] as? Int ?? 0
        work_time = data[CodingKeys.work_time.rawValue] as? Int ?? 0
        if let exercises = data[CodingKeys.exercises.rawValue] as? [Int]{
            let excercisesTimeObjects = exercises.map({ ExcercisesTimeObject(value: $0)})
            self.exercises.append(objectsIn: excercisesTimeObjects)
        }
    }
}

//
//  WorkoutsModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 14.03.21.
//

import RealmSwift

class WorkoutsModel: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    
    dynamic var rounds = List<RoundModel>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, photo, rounds
    }
    
    required convenience init(data: [String:Any]) {
        self.init()
        id = data[CodingKeys.id.rawValue] as? String ?? "0"
        name = data[CodingKeys.name.rawValue] as? String ?? ""
        photo = data[CodingKeys.photo.rawValue] as? String ?? ""
        if let rounds = data[CodingKeys.rounds.rawValue] as? [[String:Any]] {
            let round = rounds.map({ RoundModel(data: $0)})
            self.rounds.append(objectsIn: round)
        }
    }
    
}

class RoundModel: Object {
    @objc dynamic var id = UUID().uuidString
    dynamic var exercises = List<RoundExerciseModel>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case exercises
    }
    
    required convenience init(data: [String:Any]) {
        self.init()
        if let exercises = data[CodingKeys.exercises.rawValue] as? [[String:Any]] {
            let roundExercises = exercises.map({ RoundExerciseModel(data: $0)})
            self.exercises.append(objectsIn: roundExercises)
        }
    }
    
}

class RoundExerciseModel: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var count = 0
    @objc dynamic var exerciseId = ""
    @objc dynamic var rest = 0
    @objc dynamic var time = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, count, exercise_id, rest, time
    }
    
    required convenience init(data: [String:Any]) {
        self.init()
        id = data[CodingKeys.id.rawValue] as? String ?? "0"
        count = data[CodingKeys.count.rawValue] as? Int ?? 0
        exerciseId = data[CodingKeys.exercise_id.rawValue] as? String ?? "0"
        rest = data[CodingKeys.rest.rawValue] as? Int ?? 0
        time = data[CodingKeys.time.rawValue] as? Int ?? 0
        print("exerciseId -> \(exerciseId)")
    }
    
}

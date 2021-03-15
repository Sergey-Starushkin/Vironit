//
//  ApproachTraningModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 5.03.21.
//

import RealmSwift

class ApproachTraningModel: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    @objc dynamic var rest_between_exercises = 0
    dynamic var exercises = List<ExcercisesApproachObject>()

    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, photo, rest_between_exercises, exercises
    }
    
    required convenience init(data: [String:Any]) throws {
        self.init()
        id = data[CodingKeys.id.rawValue] as? String ?? "0"
        name = data[CodingKeys.name.rawValue] as? String ?? ""
        photo = data[CodingKeys.photo.rawValue] as? String ?? ""
        rest_between_exercises = data[CodingKeys.rest_between_exercises.rawValue] as? Int ?? 0

        if let exercises = data[CodingKeys.exercises.rawValue] as? [[String:Any]]{
            let excercisesTimeObjects = exercises.map({ ExcercisesApproachObject(data: $0)})
            self.exercises.append(objectsIn: excercisesTimeObjects)
        }
    }
}

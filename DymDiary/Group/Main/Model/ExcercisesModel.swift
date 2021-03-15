//
//  ExcercisesModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 10.03.21.
//

import RealmSwift

class ExcercisesModel: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var mainMuscleGroupId = ""
    @objc dynamic var exerciseMuscleGroupTypeId = ""
    @objc dynamic var exerciseTypeId = ""
    @objc dynamic var descript = ""
    
    dynamic var equipment_id = List<EquipmentModel>()
    dynamic var photos = List<PhotoExerciseModel>()
    dynamic var secondaryMuscleGroups = List<SecondaryMuscleGroupsModel>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, mainMuscleGroupId = "main_muscle_group_id", exerciseMuscleGroupTypeId = "exercise_muscle_group_type_id", exerciseTypeId = "exercise_type_id", descript = "description", equipment_id, photos, secondaryMuscleGroups = "secondary_muscle_groups_id"
    }
    
    required convenience init(data: [String:Any]) throws {
        self.init()
        id = data[CodingKeys.id.rawValue] as? String ?? "0"
        name = data[CodingKeys.name.rawValue] as? String ?? ""
        mainMuscleGroupId = data[CodingKeys.mainMuscleGroupId.rawValue] as? String ?? ""
        exerciseMuscleGroupTypeId = data[CodingKeys.exerciseMuscleGroupTypeId.rawValue] as? String ?? ""
        exerciseTypeId = data[CodingKeys.exerciseTypeId.rawValue] as? String ?? ""
        descript = data[CodingKeys.descript.rawValue] as? String ?? ""
        if let equipment_id = data[CodingKeys.equipment_id.rawValue] as? [String]{
            let equipment = equipment_id.map({ EquipmentModel(value: $0)})
            self.equipment_id.append(objectsIn: equipment)
        }
        if let photos = data[CodingKeys.photos.rawValue] as? [String]{
            let photo = photos.map({ PhotoExerciseModel(value: $0)})
            self.photos.append(objectsIn: photo)
        }
        if let secondaryMuscleGroups = data[CodingKeys.secondaryMuscleGroups.rawValue] as? [String]{
            let secondaryMuscleGroup = secondaryMuscleGroups.map({ SecondaryMuscleGroupsModel(value: $0)})
            self.secondaryMuscleGroups.append(objectsIn: secondaryMuscleGroup)
        }
    }
}

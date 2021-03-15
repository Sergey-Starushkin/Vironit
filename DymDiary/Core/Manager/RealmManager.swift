//
//  RealmManager.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 6.03.21.
//

import RealmSwift

class ApproachManager: NSObject {
    // - Realm
    private var realm = try! Realm()
    private var notificationToken: NotificationToken?
    
    var result: ApproachTraningModel? {
        let model = realm.objects(ApproachTraningModel.self).first
        return model
    }
    
    var appointments: [ApproachTraningModel] {
        let result = realm.objects(ApproachTraningModel.self)
        return Array(result)
    }

}

extension ApproachManager {
    func save(data: ApproachTraningModel) {
        try! self.realm.write {
            self.realm.add(data, update: .all)
        }
    }
}

class ExercisesApproachManager: NSObject {
    // - Realm
    private var realm = try! Realm()
    private var notificationToken: NotificationToken?
    
    var result: ExcercisesApproachObject? {
        let model = realm.objects(ExcercisesApproachObject.self).first
        return model
    }
    
    var appointments: [ExcercisesApproachObject] {
        let result = realm.objects(ExcercisesApproachObject.self)
        return Array(result)
    }

}

extension ExercisesApproachManager {
    func save(data: ExcercisesApproachObject) {
        try! self.realm.write {
            self.realm.add(data, update: .all)
        }
    }
    
    func findExercise(id: Int) -> Results<ExcercisesApproachObject>{
        let traning = realm.objects(ExcercisesApproachObject.self).filter("userId='\(id)'")
        return traning
    }
}

class TimeManager: NSObject {
    // - Realm
    private var realm = try! Realm()
    private var notificationToken: NotificationToken?
    
    var result: StaticTimeModel? {
        let model = realm.objects(StaticTimeModel.self).first
        return model
    }
    
    var appointments: [StaticTimeModel] {
        let result = realm.objects(StaticTimeModel.self)
        return Array(result)
    }

}

extension TimeManager {
    func save(data: StaticTimeModel) {
        try! self.realm.write {
            self.realm.add(data, update: .all)
        }
    }
    
    func findTimeTraning(id: Int) -> WorkoutsModel{
        let traning = realm.objects(WorkoutsModel.self).filter("id='\(id)'").first
        return traning!
    }
}

class ExcercisesManager: NSObject {
    // - Realm
    private var realm = try! Realm()
    private var notificationToken: NotificationToken?
    
    var result: ExcercisesModel? {
        let model = realm.objects(ExcercisesModel.self).first
        return model
    }
    
    var appointments: [ExcercisesModel] {
        let result = realm.objects(ExcercisesModel.self)
        return Array(result)
    }

}

extension ExcercisesManager {
    func save(data: ExcercisesModel) {
        try! self.realm.write {
            self.realm.add(data, update: .all)
        }
    }
    func findExerc(id: String) -> ExcercisesModel? {
        let excercises = realm.objects(ExcercisesModel.self).filter("id='\(id)'").first
        return excercises
    }
    func findMusc(id: Int) -> MuscleGroupModel? {
        let excercises = realm.objects(MuscleGroupModel.self).filter("id='\(id)'").first
        return excercises
    }
    func findExercType(id: Int) -> ExcersicesTypesModel? {
        let excercises = realm.objects(ExcersicesTypesModel.self).filter("id='\(id)'").first
        return excercises
    }
    func findEquipment(item: List<EquipmentModel>) -> String {
        var result = ""
        for i in 0..<item.count {
            let id = item[i].value
            let excercises = realm.objects(ExcersicesEquipmentModel.self).filter("id='\(id)'")
            for item in excercises {
                result += "\(item.name) "
            }
        }
        return result
    }
    func findSecondMuscl(item: List<SecondaryMuscleGroupsModel>) -> String {
        var result = ""
        for i in 0..<item.count {
            let id = item[i].value
            let excercises = realm.objects(MuscleGroupModel.self).filter("id='\(id)'")
            for item in excercises {
                result += "\(item.name) "
            }
        }
        return result
    }
}

class HistoryManager: NSObject {
    // - Realm
    private var realm = try! Realm()
    private var notificationToken: NotificationToken?
    let keychain = KeychainManager.shared
    
    var result: HistoryModel? {
        let model = realm.objects(HistoryModel.self).first
        return model
    }
    
    var appointments: [HistoryModel] {
        let result = realm.objects(HistoryModel.self)
        return Array(result)
    }

}

extension HistoryManager {
    func save(data: HistoryModel) {
        try! self.realm.write {
            self.realm.add(data, update: .all)
        }
    }
    
    func findHistory() -> Results<HistoryModel>{
        let traning = realm.objects(HistoryModel.self).filter("userId='\(keychain.get(key: .id))'")
        return traning
    }
}

class WorkoutsManager: NSObject {
    // - Realm
    private var realm = try! Realm()
    private var notificationToken: NotificationToken?
    
    var workouts: [WorkoutsModel] {
        let result = realm.objects(WorkoutsModel.self)
        return Array(result)
    }

}

extension WorkoutsManager {
    
    func save(workouts: [WorkoutsModel]) {
        try! self.realm.write {
            let oldWorkouts = realm.objects(WorkoutsModel.self)
            self.realm.delete(oldWorkouts)
            self.realm.add(workouts, update: .all)
        }
    }
    
    func findHistory(id: String) -> Results<WorkoutsModel>{
        let traning = realm.objects(WorkoutsModel.self).filter("id='\(id)'")
        return traning
    }
}


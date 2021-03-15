//
//  SecondaryMuscleGroupsModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 10.03.21.
//

import RealmSwift

class SecondaryMuscleGroupsModel: Object, Codable {
    
    @objc dynamic var value = ""
    
    override public static func primaryKey() -> String? {
        return "value"
    }
    
    override init() {
        super.init()
    }

    init(value: String) {
        super.init()
        self.value = value
    }
}

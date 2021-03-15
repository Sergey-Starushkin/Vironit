//
//  GrabData.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 25.02.21.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import RealmSwift

class GrabData {
    
    private let approachManager = ApproachManager()
    private let timeManager = TimeManager()
    private let excercisesManager = ExcercisesManager()
    private let historyManager = HistoryManager()
    private let realmManager = try! Realm()
    private var db: Firestore!
    private let workoutsManager = WorkoutsManager()
    let nc = NotificationCenter.default
    
    func grabUserData() {
        db = Firestore.firestore()
        db.collection("UserData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    try! self.realmManager.write {
                    let user = try! UserModel.init(data: document.data())
                        self.realmManager.add(user, update: .all)
                    }
                }
            }
        }
        print("ADDRES \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    func gramMuscleGroup() {
        db = Firestore.firestore()
        db.collection("excercises_muscle_group_types").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    try! self.realmManager.write {
                    let musc = try! MuscleGroupModel.init(data: document.data())
                        self.realmManager.add(musc, update: .all)
                    }
                }
            }
        }
    }
    
    func gramExcersicesEquipmentGroup() {
        db = Firestore.firestore()
        db.collection("excersices_equipment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    try! self.realmManager.write {
                    let musc = try! ExcersicesEquipmentModel.init(data: document.data())
                        self.realmManager.add(musc, update: .all)
                    }
                }
            }
        }
    }
    
    func gramProgramsPlaceGroup() {
        db = Firestore.firestore()
        db.collection("programs_place").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    try! self.realmManager.write {
                    let musc = try! ProgramsPlaceModel.init(data: document.data())
                        self.realmManager.add(musc, update: .all)
                    }
                }
            }
        }
    }
    
    func gramExcersicesTypesGroup() {
        db = Firestore.firestore()
        db.collection("programs_place").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    try! self.realmManager.write {
                    let musc = try! ExcersicesTypesModel.init(data: document.data())
                        self.realmManager.add(musc, update: .all)
                    }
                }
            }
        }
    }
    
    func grabApproachTraining() {
        db = Firestore.firestore()
        db.collection("Static_approach_program").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let user = try! ApproachTraningModel.init(data: document.data())
                    self.approachManager.save(data: user)
                }
            }
    }

}
    
    func grabTimeTraining() {
        db = Firestore.firestore()
        db.collection("Static_time_programm").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let user = try! StaticTimeModel.init(data: document.data())
                    self.timeManager.save(data: user)
                }
            }
        }
        
    }
    
    func grabExcercises() {
        db = Firestore.firestore()
        db.collection("excercises").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let user = try! ExcercisesModel.init(data: document.data())
                    self.excercisesManager.save(data: user)
                }
            }
        }
        
    }
    
    func grabHistory() {
        db = Firestore.firestore()
        db.collection("history").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let user = try! HistoryModel.init(data: document.data())
                    self.historyManager.save(data: user)
                }
            }
        }
        
    }
    
    func grabWorkouts() {
        db = Firestore.firestore()
        db.collection("workouts").getDocuments() { (querySnapshot, error) in
            if let documents = querySnapshot?.documents {
                let workouts: [WorkoutsModel] = documents.map({ WorkoutsModel(data: $0.data())})
                self.workoutsManager.save(workouts: workouts)
            }
            self.nc.post(name: Notification.Name("Workouts"), object: nil)        }
    }
    
    func grabData() {
        grabUserData()
        gramMuscleGroup()
        gramExcersicesEquipmentGroup()
        gramProgramsPlaceGroup()
        gramExcersicesTypesGroup()
        grabApproachTraining()
        grabTimeTraining()
        grabExcercises()
        grabHistory()
        grabWorkouts()
        
    }

}

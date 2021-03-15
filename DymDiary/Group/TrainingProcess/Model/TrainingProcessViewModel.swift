//
//  TrainingProcessViewModel.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 9.03.21.
//

import Foundation

class TrainingProcessViewModel: NSObject {
    
    private(set) var model: WorkoutsModel?
    private(set) var currentExerciseIndex = 0
    private(set) var exercises: [[RoundExerciseModel]] = []
    private(set) var numberOfExercises = 1
    var isRest = false
    var isFinish = false

    func set(model: WorkoutsModel?) {
        guard let model = model else { return }
        self.model = model
        model.rounds.forEach({
            exercises.append(Array($0.exercises))
        })
    }
    
    var numberOfRounds: Int {
        return (model?.rounds.count ?? 0) - (exercises.count - 1)
    }
    
    func next() {
        if exercises.first?.count == 1 {
            exercises.removeFirst()
            numberOfExercises = 1
        } else {
            if exercises.count == 0 { return }
            exercises[0] = Array(exercises.first?.dropFirst() ?? [])
            numberOfExercises += 1
        }
    }
    
    var exercise: RoundExerciseModel? {
        return exercises.first?.first
    }
    
    var nextExercise: RoundExerciseModel? {
        var exercises = self.exercises
        if self.exercises.first?.count == 1 {
            exercises = Array(self.exercises.dropFirst())
        } else {
            if exercises.count == 0 { return nil }
            exercises[0] = Array(self.exercises.first?.dropFirst() ?? [])
        }
        return exercises.first?.first
    }
}

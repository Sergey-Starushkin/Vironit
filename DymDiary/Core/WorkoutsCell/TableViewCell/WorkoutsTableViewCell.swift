//
//  WorkoutsTableViewCell.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 24.02.21.
//

import UIKit

class WorkoutsTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var traningNameLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var exercicesCountLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "WorkoutsTableViewCell", bundle: nil)
    }
    
    public func configure(workout: WorkoutsModel) {
        traningNameLabel.text = workout.name
        backImageView.sd_setImage(with: URL(string: workout.photo))
        let numbExercices = workout.rounds.map({ $0.exercises.count }).reduce(0, +)
        exercicesCountLabel.text = String(numbExercices) + " exercices"
    }
    
}

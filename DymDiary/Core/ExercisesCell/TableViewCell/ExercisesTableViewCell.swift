//
//  ExercisesTableViewCell.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 10.03.21.
//

import UIKit

class ExercisesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exercisesLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "ExercisesTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String){
        exercisesLabel.text = title
    }
    
}

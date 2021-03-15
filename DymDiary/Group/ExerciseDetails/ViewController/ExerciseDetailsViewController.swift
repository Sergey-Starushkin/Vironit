//
//  ExerciseDetailsViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 11.03.21.
//

import UIKit

class ExerciseDetailsViewController: UIViewController {
    
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var exerciseMuscleGroupTypeLabel: UILabel!
    @IBOutlet weak var exerciseTypeLabel: UILabel!
    @IBOutlet weak var mainMuscleGroupLabel: UILabel!
    @IBOutlet weak var muscleGroupsLabel: UILabel!
    @IBOutlet weak var nameExerciseLabel: UILabel!
    @IBOutlet weak var photoMusculOne: UIImageView!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var photoMusculTwo: UIImageView!
    
    var model = ExcercisesModel()
    var exerciseManager = ExcercisesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override var prefersStatusBarHidden: Bool {
           return true
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        backButton()
    }
    
}


// MARK: - Navigation
extension ExerciseDetailsViewController{
    
    func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    

}

// MARK: - Setter
extension ExerciseDetailsViewController{
    
    func set(model: ExcercisesModel) {
        self.model = model
    }
}


// MARK: - Navigation
extension ExerciseDetailsViewController{
    
    func configure() {
        navigationController?.setToolbarHidden(true, animated: false)
        nameExerciseLabel.text = "Exercise name: \(model.name)"
        decriptionLabel.text = model.descript
        photoMusculOne.sd_setImage(with: URL(string: model.photos[0].value))
        photoMusculTwo.sd_setImage(with: URL(string: model.photos[1].value))
        mainMuscleGroupLabel.text = "Main Muscle Group: \(exerciseManager.findMusc(id:Int(model.mainMuscleGroupId) ?? 0)?.name ?? "-")"
        exerciseMuscleGroupTypeLabel.text = "Exercise Muscle Group Type: \(exerciseManager.findMusc(id: Int(model.exerciseMuscleGroupTypeId) ?? 0)?.name ?? "-")"
        exerciseTypeLabel.text = "Exercise type: \(exerciseManager.findExercType(id: Int(model.exerciseTypeId) ?? 0)?.name ?? "-")"
        equipmentLabel.text = "Equipment: \(exerciseManager.findEquipment(item: model.equipment_id))"
        muscleGroupsLabel.text = "Secondary muscle groups: \(exerciseManager.findSecondMuscl(item: model.secondaryMuscleGroups))"

    }
}

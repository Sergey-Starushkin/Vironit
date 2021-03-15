 //
//  WorkoutViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 16.02.21.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - Manager
    private let approachManager = ApproachManager()
    private let timeManager = TimeManager()
    private let workoutsManager = WorkoutsManager()
    
    // - Data
    private var workouts: [WorkoutsModel] = []
    let cellId = "WorkoutsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}

// MARK: - Navigation
extension WorkoutViewController {
    
    func showTrainingProcessVC(index: Int) {
        let vc = UIStoryboard(storyboard: .trainingProcess).instantiateInitialViewController() as! TrainingProcessViewController
        vc.viewModel.set(model: workouts[index])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showWorkoutDetails(index: Int) {
        let vc = UIStoryboard(storyboard: .workoutDetails).instantiateInitialViewController() as! WorkoutDetailsViewController
        vc.trainingProcessViewModel.set(model: workouts[index])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - TableView
extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WorkoutsTableViewCell
        cell.configure(workout: workouts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            showWorkoutDetails(index: indexPath.row)
        }
    }
    
    
}

// MARK: - Configure

extension WorkoutViewController {
    
    func configure() {
        configureWorkouts()
        configureTableView()
    }
    
    func configureWorkouts() {
        workouts = workoutsManager.workouts
    }
    
    func configureTableView(){
        tableView.reloadData()
        self.tableView.register(WorkoutsTableViewCell.nib(), forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

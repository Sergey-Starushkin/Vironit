//
//  WorkoutDetailsViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 10.03.21.
//

import UIKit

class WorkoutDetailsViewController: UIViewController {
    // - UI
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let excercisesManager = ExcercisesManager()
    
    // - Data
    let trainingProcessViewModel = TrainingProcessViewModel()
    private let cellId = "ExercisesTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var prefersStatusBarHidden: Bool {
           return true
    }
    
    @IBAction func clickBackButton(_ sender: UIButton) {
        backButton()
    }
    @IBAction func clickStartButton(_ sender: UIButton) {
        startButton()
    }
    
}

// MARK: - Navigation
extension WorkoutDetailsViewController{
    
    func showTrainingProcessVC() {
        let vc = UIStoryboard(storyboard: .trainingProcess).instantiateInitialViewController() as! TrainingProcessViewController
        vc.viewModel.set(model: trainingProcessViewModel.model)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func showExerciseDetailVC(ind: Int) {
        let vc = UIStoryboard(storyboard: .exerciseDetails).instantiateInitialViewController() as! ExerciseDetailsViewController
        guard let inputModel = excercisesManager.findExerc(id: "\(ind)") else { return }
        vc.set(model: inputModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Configure
extension WorkoutDetailsViewController {
    
    func configure(){
        navigationController?.setToolbarHidden(true, animated: false)
        photoImageView.sd_setImage(with: URL(string: (trainingProcessViewModel.model?.photo) ?? ""))
        nameLabel.text = trainingProcessViewModel.model?.name
        configureDescription()
        configureTableView()
    }
    
    func configureDescription() {
        guard let rounds = trainingProcessViewModel.model?.rounds else { return }
        let timeOfEachExercise = rounds.map({ $0.exercises.map({ ($0.time + $0.count + $0.rest) }).reduce(0, +)})
        roundsLabel.text = "Rounds: \(rounds.count)"
        workTimeLabel.text = "Work Time: \(timeOfEachExercise.reduce(0, +) / 60) MIN"
    }
    
    func configureTableView(){
        self.tableView.register(ExercisesTableViewCell.nib(), forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Table View
extension WorkoutDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return trainingProcessViewModel.exercises.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingProcessViewModel.exercises[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ExercisesTableViewCell
        let id = trainingProcessViewModel.exercises[indexPath.section][indexPath.row].exerciseId
        cell.configure(with: "\(excercisesManager.findExerc(id: id)?.name ?? "")")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showExerciseDetailVC(ind: Int(trainingProcessViewModel.exercises[indexPath.section][indexPath.row].exerciseId) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 40))
        headerView.backgroundColor = .tertiarySystemGroupedBackground
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 5, width: screenWidth - 16, height: 40)
        label.text = "Round \(section + 1)"
        label.font = AppFont.medium(size: 14)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

// MARK: - Start and back button
extension WorkoutDetailsViewController {
    func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func startButton() {
        showTrainingProcessVC()
    }
}

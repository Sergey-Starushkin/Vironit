//
//  TrainingProcessViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 9.03.21.
//

import UIKit
import Lottie

class TrainingProcessViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var currentExerciseLabel: UILabel!
    @IBOutlet weak var traningNameLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var nextExerciseView: UIView!
    @IBOutlet weak var currentWorkoutNumberLabel: UILabel!
    @IBOutlet weak var nextExerciseLabel: UILabel!
    @IBOutlet weak var timeLabel: CountdownLabel!
    private let animation = AnimationView(name: "fireworks")
    
    // - Manager
    private let excercisesManager = ExcercisesManager()
    private let firebaseManager = FirebaseDatabase()
    
    // - Data
    let viewModel = TrainingProcessViewModel()
    
    private let grabData = GrabData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.exercise?.time ?? 0 > 0 {
            timeLabel.start()
        }
    }

}

// MARK: - Action
private extension TrainingProcessViewController {
    
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        if timeLabel.isPaused {
            timeLabel.start()
            pauseButton.setTitle("PAUSE", for: .normal)
        } else {
            timeLabel.pause()
            pauseButton.setTitle("START", for: .normal)
        }
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if viewModel.isFinish {
            navigationController?.popViewController(animated: true)
        } else {
            updateCurrentExercise()
        }
    }
    
    func finish() {
        startAnimation()
        viewModel.isFinish = true
        nextButton.setTitle("Complete workout", for: .normal)
        pauseButton.isHidden = true
        currentWorkoutNumberLabel.isHidden = true
        currentExerciseLabel.isHidden = true
        restLabel.isHidden = true
        timeLabel.cancel()
        timeLabel.text = "FINISH"
        let id = viewModel.model?.id ?? "0"
        firebaseManager.saveTraning(id: id, mounth: getMonth(), day: getDay())
        grabData.grabHistory()
    }
    
    func startAnimation() {
        animation.frame = CGRect(x: 0, y: 0, width: animationView.frame.width, height: animationView.frame.height)
        animationView.addSubview(animation)
        animation.loopMode = .loop
        animation.play()
    }
    
}

// MARK: - Update
private extension TrainingProcessViewController {
    
    func updateNextExercise() {
        nextExerciseLabel.text = "Text"
        if viewModel.nextExercise == nil {
            nextExerciseView.isHidden = true
            nextButton.setTitle("FINISH", for: .normal)
        }
    }
    
    func updateCurrentExercise() {
        if viewModel.isRest == true {
            viewModel.next()
            setupNextExercise()
            if viewModel.exercise == nil {
                finish()
            } else if viewModel.exercise?.time ?? 0 > 0 {
                setupTimeExercise()
            } else {
                setupCountExercise()
            }
        } else {
            setupRest()
        }
        pauseButton.setTitle("PAUSE", for: .normal)
    }
        
}

// MARK: - Setup
private extension TrainingProcessViewController {
    
    func setupNextExercise() {
        viewModel.isRest = false
        restLabel.isHidden = true
        updateNextExercise()
        let currentExc = excercisesManager.findExerc(id: viewModel.exercise?.exerciseId ?? "")
        let nextExc = excercisesManager.findExerc(id: viewModel.nextExercise?.exerciseId ?? "")
        currentExerciseLabel.text = "Current: \(currentExc?.name ?? "")"
        nextExerciseLabel.text = nextExc?.name ?? ""
        currentWorkoutNumberLabel.text = "Round \(viewModel.numberOfRounds) Excercises \(viewModel.numberOfExercises)"
    }
    
    func setupRest() {
        restLabel.isHidden = false
        pauseButton.isHidden = false
        timeLabel.setCountDownTime(minutes: TimeInterval(viewModel.exercise?.rest ?? 0))
        viewModel.isRest = true
        timeLabel.start()
        if viewModel.nextExercise == nil {
            finish()
        }
    }
    
    func setupTimeExercise() {
        pauseButton.isHidden = false
        timeLabel.setCountDownTime(minutes: TimeInterval(viewModel.exercise?.time ?? 0))
        timeLabel.start()
    }
    
    func setupCountExercise() {
        timeLabel.cancel()
        pauseButton.isHidden = true
        timeLabel.text = "Count: \(viewModel.exercise?.count ?? 0)"
    }
    
}

// MARK: - Configure
private extension TrainingProcessViewController {
    
    func configure() {
        configureRelaxTimeLabel()
        traningNameLabel.text = "\(viewModel.model?.name ?? "New traning")"
        setupNextExercise()
    }
    
    func configureRelaxTimeLabel() {
        timeLabel.timeFormat = "mm:ss"
        timeLabel.countdownDelegate = self
        timeLabel.animationType = .None
        if viewModel.exercise?.time ?? 0 > 0 {
            setupTimeExercise()
        } else {
            setupCountExercise()
        }
    }
    
}


// MARK: - CountdownLabelDelegate
extension TrainingProcessViewController: CountdownLabelDelegate {
    
    func countdownFinished(label: CountdownLabel) {
        
    }
    
    func countingAt(label: CountdownLabel, counted: TimeInterval, remaining: TimeInterval) {
        if remaining == 0 {
            updateCurrentExercise()
        }
    }
    
}

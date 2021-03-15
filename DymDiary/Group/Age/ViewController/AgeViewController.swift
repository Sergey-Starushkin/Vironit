//
//  AgeViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 3.02.21.
//

import UIKit

final class AgeViewController: UIViewController {

    // - UI
    @IBOutlet weak var pikerView: UIDatePicker!
    @IBOutlet weak var continueButton: UIButton!
    
    // - Delegate
    var delegate: UserDataDelegate?
    
    // - Data
    private var user = UserDataModel()
    
    // - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func set(user: UserDataModel) {
        self.user = user
    }
    
}

//MARK: - Action
extension AgeViewController {
    
    @IBAction func clickContinueButton(_ sender: UIButton) {
        if Calendar.current.dateComponents([.year], from: pikerView.date, to: Date()).year ?? 0 > majority {
            delegate?.didTabOnContinue()
        } else {
            warning(title: alertAgeTitle, message: alertAgeMessage)
        }
        
    }
    
    @IBAction func choiceDate(_ sender: Any) {
        user.birthday = pikerView.date
        user.age = (Calendar.current.dateComponents([.day], from: user.birthday, to: Date()).day ?? 0) / year
    }
    
}

// MARK: - Navigation
private extension AgeViewController {
    
    func showMainVC() { 
        let vc = UIStoryboard(storyboard: .main).instantiateInitialViewController() as! MainTabBarController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
// MARK: - Configure
private extension AgeViewController {
    
    func configure() {
        continueButton.startAnimatingPressActions()
        navigationController?.setToolbarHidden(true, animated: false)
        configureCornerRadius()
    }
    
    func configureCornerRadius() {
        continueButton.layer.cornerRadius = 10
    }
    
}

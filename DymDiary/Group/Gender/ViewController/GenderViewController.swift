//
//  GenderViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 3.02.21.
//

import UIKit

class GenderViewController: UIViewController {

    // - UI
    @IBOutlet var genderButoonCollection: [UIButton]!
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
extension GenderViewController{
    
    @IBAction func genderButton(_ sender: UIButton) {
        clickGenderButton(sender: sender)
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        delegate?.didTabOnContinue()
    }
    
    func clickGenderButton(sender: UIButton) {
        genderButoonCollection.forEach({ $0.backgroundColor = .lightGray })
        genderButoonCollection[sender.tag].backgroundColor = #colorLiteral(red: 0.968627451, green: 0.1764705882, blue: 0.4862745098, alpha: 1)
        genderButoonCollection[sender.tag].tintColor = .white
        switch sender.tag {
            case 1:  user.gender = .female
            case 2:  user.gender = .other
            default: user.gender = .male
        }
    }
    
}

// MARK: - Navigation
extension GenderViewController {
    
    func showMainVC() {
        let vc = UIStoryboard(storyboard: .main).instantiateInitialViewController() as! MainTabBarController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
// MARK: - Configure
private extension GenderViewController {
    
    func configure() {
        genderButoonCollection.forEach({ $0.startAnimatingPressActions() }) 
        continueButton.startAnimatingPressActions()
        navigationController?.setToolbarHidden(true, animated: false)
        configureCornerRadius()
    }
    
    func configureCornerRadius() {
        genderButoonCollection[0].layer.cornerRadius = 40
        genderButoonCollection[1].layer.cornerRadius = 40
        genderButoonCollection[2].layer.cornerRadius = 40
        continueButton.layer.cornerRadius = 10
    }
    
}

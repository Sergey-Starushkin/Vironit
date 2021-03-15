//
//  UserWeightViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 5.02.21.
//

import UIKit

class WeightViewController: UIViewController {

    // - UI
    @IBOutlet weak var userWeightTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var userWeightStackView: UIStackView!
    
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

//MARK: - Navigation
extension WeightViewController {
    
    @IBAction func clickContinueButton(_ sender: UIButton) {
        if userWeightTextField.text != ""{
            user.weignt = Double(userWeightTextField.text ?? "0.0") ?? 0.0
            delegate?.didTabOnContinue()
        } else {
            warning(title: "The field is empty", message: "Please fill in the field to continue")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

// MARK: - Configure
private extension WeightViewController {
    
    func configure() {
        continueButton.startAnimatingPressActions()
        navigationController?.setToolbarHidden(true, animated: false)
        configureCornerRadius()
    }
    
    func configureCornerRadius() {
        continueButton.layer.cornerRadius = 10
        userWeightStackView.layer.cornerRadius = 10
        userWeightTextField.layer.cornerRadius = 10
    }
    
}

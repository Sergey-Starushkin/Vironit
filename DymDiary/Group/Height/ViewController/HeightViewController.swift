//
//  HeightViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 5.02.21.
//

import UIKit

class HeightViewController: UIViewController {

    // - UI
    @IBOutlet weak var heightInputTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var userHeightStackView: UIStackView!
   
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
extension HeightViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func clickContinueButton(_ sender: UIButton) {
        if heightInputTextField.text != ""{
            user.height = Double(heightInputTextField.text ?? "0.0") ?? 0.0
            delegate?.didTabOnContinue()
        } else {
            warning(title: "The field is empty", message: "Please fill in the field to continue")
        }
    }
    
}

// MARK: - Configure
private extension HeightViewController {
    
    func configure() {
        continueButton.startAnimatingPressActions()
        navigationController?.setToolbarHidden(true, animated: false)
        configureCornerRadius()
    }
    
    func configureCornerRadius() {
        continueButton.layer.cornerRadius = 10
        heightInputTextField.layer.cornerRadius = 10
        userHeightStackView.layer.cornerRadius = 10
    }
    
    
}

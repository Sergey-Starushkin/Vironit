//
//  UserData.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 3.02.21.
//

import UIKit

class UserDataViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var scrollView: UIScrollView!
    
    // - Constraint
    @IBOutlet weak var progressViewRightConstraint: NSLayoutConstraint!
    
    // - Manager
    var screens: [UIViewController] = []
    private let keychain = KeychainManager.shared
    private let firebase = FirebaseDatabase()
    
    // - Data
    private var user = UserDataModel()
    
    // - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: - Request
extension UserDataViewController {
    
    func saveUserData() {
        firebase.addUser(user: user) { [weak self] error in
            if let massege = error?.localizedDescription {
                self?.showErrorAlert(title: massege)
            } else {
                self?.showMainVC()
            }
        }
    }
    
}

// MARK: - Navigation
extension UserDataViewController {
    
    func showMainVC() {
        let vc = UIStoryboard(storyboard: .main).instantiateInitialViewController() as! MainTabBarController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}

//MARK: - UserDataDelegate
extension UserDataViewController: UserDataDelegate {
    
    func didTabOnContinue() {
        if scrollView.contentOffset.x >= screenWidth * 4 {
            saveUserData()
        } else {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.scrollView.contentOffset.x += screenWidth
                self?.progressViewRightConstraint.constant += (screenWidth / 5)
                self?.view.layoutIfNeeded()
            }
        }
    }
    
}

// MARK: - Configure
extension UserDataViewController {
    
    func configure() {
        progressViewRightConstraint.constant = -(screenWidth / 4 * 4) + 5
        configureScreens()
        setupScrollView()
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.bounds.width * 4, height: 1)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        view.layoutIfNeeded()
        setupViewContolleraOnScrollView()
    }
    
    func configureScreens() {
        let gender = UIStoryboard(storyboard: .gender).instantiateInitialViewController() as! GenderViewController
        let age = UIStoryboard(storyboard: .age).instantiateInitialViewController() as! AgeViewController
        let weight = UIStoryboard(storyboard: .weight).instantiateInitialViewController() as!   WeightViewController
        let height = UIStoryboard(storyboard: .height).instantiateInitialViewController() as! HeightViewController
        let photo = UIStoryboard(storyboard: .userPhoto).instantiateInitialViewController() as! UserPhotoViewController
        
        gender.delegate = self
        age.delegate = self
        weight.delegate = self
        height.delegate = self
        photo.delegate = self
        
        gender.set(user: user)
        age.set(user: user)
        weight.set(user: user)
        height.set(user: user)
        
        screens = [gender, age, weight, height, photo]
    }
    
    func setupViewContolleraOnScrollView(){
        let yPosition = Int(self.scrollView.contentOffset.y)
        screens.enumerated().forEach{
            self.addChild($1)
            scrollView.addSubview($1.view)
            $1.willMove(toParent: self)
            $1.view.frame.origin = CGPoint(x: Int(self.view.bounds.width) * $0, y: yPosition)
            scrollView.delegate = $1 as? UIScrollViewDelegate
        }
    }
    
}

// MARK: - Alert
extension UserDataViewController{
    
    func showErrorAlert(title: String) {
        let alert = UIAlertController(title: title , message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAgeAlert(){
        let alert = UIAlertController(title: alertAgeTitle , message: alertAgeMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

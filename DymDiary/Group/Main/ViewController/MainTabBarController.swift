//
//  MianViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 1.02.21.
//

import UIKit
import FirebaseUI

class MainTabBarController: UITabBarController {
    
    // - UI
    let nc = NotificationCenter.default
    
    // - Manager
    private let keychain = KeychainManager.shared
    private let grabData = GrabData()
    private var user = UserDataModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }


}

//MARK: - Navigation
extension MainTabBarController {
    
    func showSignInVC() {
        let vc = UIStoryboard(storyboard: .signIn).instantiateInitialViewController() as! SignInViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}

// MARK: - Configure
private extension MainTabBarController {
    
    func configure() {
        navigationController?.setToolbarHidden(true, animated: false)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        grabData.grabData()
    }
}

//MARK: - Action
extension MainTabBarController {
    
}


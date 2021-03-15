//
//  SettingsViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 16.02.21.
//

import UIKit
import FirebaseUI
import FirebaseStorage

class SettingsViewController: UIViewController {
    @IBOutlet weak var elementSettingsTableView: UITableView!
    
    // - Manager
    private let keychain = KeychainManager.shared
    private var cells: [SettingsCell] = SettingsCell.allCases.map{ $0 }
    private let cellId = "SettingsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

    }
    func logOut() {
        do { try Auth.auth().signOut() }
            catch { print("already logged out") }
        showSignInVC()
        keychain.deleteKeychainData()
    }
    
    @IBAction func clickLogOutButton(_ sender: Any) {
        logOut()
    }
    
}

// MARK: - Navigation
extension SettingsViewController {
    
    func showSignInVC() {
        let vc = UIStoryboard(storyboard: .signIn).instantiateInitialViewController() as! SignInViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    func showPrivacyPolicy() {
        let vc = UIStoryboard(storyboard: .privacy).instantiateInitialViewController() as! PrivacyPolicyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func showTermsOfUseVC() {
        let vc = UIStoryboard(storyboard: .termsOfUse).instantiateInitialViewController() as! TermsOfUseViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Table view
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingsTableViewCell
        cell.configure(with: cells[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        switch cells[indexPath.row].rawValue {
        case "termsOfUse":
            showTermsOfUseVC()
        case "privacyPolicy":
            showPrivacyPolicy()
        default:
            logOut()
        }
    }
    
    
}

// MARK: - Configure
extension SettingsViewController {
    func configure() {
            self.elementSettingsTableView.register(SettingsTableViewCell.nib(), forCellReuseIdentifier: cellId)
            elementSettingsTableView.delegate = self
            elementSettingsTableView.dataSource = self
    }
}

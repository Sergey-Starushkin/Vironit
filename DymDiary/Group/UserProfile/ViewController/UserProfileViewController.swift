//
//  UserProfileViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 23.02.21.
//

import UIKit
import RealmSwift

class UserProfileViewController: UIViewController {
    @IBOutlet weak var parametrUserStackView: UIStackView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // - Manager
    private let keychain = KeychainManager.shared
    let realm = try! Realm()
    private let timeManager = TimeManager()
    private var historyData = HistoryManager().findHistory()
    private let workoutsManager = WorkoutsManager()
    
    let cellId = "HistoryTableViewCell"
    
    // - Data
    private var user: UserModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    @IBAction func clickBackButton(_ sender: UIButton) {
        backButton()
    }
}
// MARK: - Navigation

extension UserProfileViewController{
    func backButton(){
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Configure
extension UserProfileViewController{
    func configure(){
        getRealmUserData()
        parametrUserStackView.layer.cornerRadius = 10
        parametrUserStackView.clipsToBounds = true
        userPhotoImageView.layer.cornerRadius = 65
        userPhotoImageView.clipsToBounds = true
        userPhotoImageView.sd_setImage(with: URL(string: user?.photoUrl ?? ""), completed: nil)
        historyLabel.layer.cornerRadius = 10
        historyLabel.clipsToBounds = true
        configureParametrLabel()
        configureTableView()
    }
    
    func configureTableView(){
        self.tableView.register(HistoryTableViewCell.nib(), forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureParametrLabel() {
        userNameLabel.text = keychain.get(key: .name)
        weightLabel.text = String(user?.weight ?? 0.0) + "kg"
        heightLabel.text = String(user?.height ?? 0.0) + "cm"
        yearsLabel.text = String(user?.age ?? 0)
    }
    func getRealmUserData() {
        user = realm.objects(UserModel.self).filter("id='\(keychain.get(key: .id))'").first
    }
}

// MARK: - Table view
extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HistoryTableViewCell
        cell.configure(with: workoutsManager.findHistory(id: historyData[indexPath.row].programId).first?.name ?? "", day: historyData[indexPath.row].day, mounth: historyData[indexPath.row].month)
        return cell
    }
    
}


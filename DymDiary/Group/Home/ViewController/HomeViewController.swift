//
//  HomeViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 16.02.21.
//

import UIKit
import FirebaseUI
import FirebaseStorage
import SDWebImage
import RealmSwift

class HomeViewController: UIViewController {
    
    
    // - UI
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var traningTableView: UITableView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    let realm = try! Realm()
    private var user: UserModel? = nil
    let trainingProcessViewModel = TrainingProcessViewModel()
    private let grabData = GrabData()
    
    // - Manager
    private let keychain = KeychainManager.shared
    private let workoutsManager = WorkoutsManager()
    
    
    // - Data
    private let cellId = "WorkoutsTableViewCell"
    private var workouts: [WorkoutsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}


//MARK: - Navigation
extension HomeViewController {
    
    func showSignInVC() {
        let vc = UIStoryboard(storyboard: .signIn).instantiateInitialViewController() as! SignInViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    @objc func showUserProfileVC() {
        let vc = UIStoryboard(storyboard: .userProfile).instantiateInitialViewController() as! UserProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func showWorkoutDetails(index: Int) {
        let vc = UIStoryboard(storyboard: .workoutDetails).instantiateInitialViewController() as! WorkoutDetailsViewController
        vc.trainingProcessViewModel.set(model: workouts[index])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Configure
private extension HomeViewController {
    
    func configure() {
        navigationController?.setToolbarHidden(true, animated: false)
        getRealmUserData()
        configureTitle()
        configureImage()
        configureWorkouts()
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("Workouts"), object: nil)
    }
    
    func configureWorkouts() {
        workouts = workoutsManager.workouts
    }
    
    func configureTitle() {
        let name = keychain.get(key: .name)
        userName.text = name
    }
    func configureImage(){
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(showUserProfileVC))
        userPhotoImageView.addGestureRecognizer(tapImageView)
        userPhotoImageView.isUserInteractionEnabled = true
        userPhotoImageView.layer.cornerRadius = 30
        userPhotoImageView.clipsToBounds = true
        let url = user?.photoUrl ?? ""
        if url.isEmpty == false {
            userPhotoImageView.sd_setImage(with: URL(string: url), completed: nil)
            userPhotoImageView.sd_setImage(with: URL(string: url)) { [weak self] (_, error, _, _) in
                if error != nil {
                    self?.userPhotoImageView.image = #imageLiteral(resourceName: "anonymous")
                }
            }
        }
    }
    
    func configureTableView(){
        self.traningTableView.register(WorkoutsTableViewCell.nib(), forCellReuseIdentifier: cellId)
        traningTableView.delegate = self
        traningTableView.dataSource = self
    }
    
    func getRealmUserData() {
        user = realm.objects(UserModel.self).filter("id='\(keychain.get(key: .id))'").first
    }
    
}

//MARK: - Action
extension HomeViewController {
    
    func logOut() {
        do { try Auth.auth().signOut() }
            catch { print("already logged out") }
        showSignInVC()
        keychain.deleteKeychainData()
    }
    
    
}

// MARK: - TableView

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count == 0 ? 0 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WorkoutsTableViewCell
        cell.configure(workout: workouts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showWorkoutDetails(index: indexPath.row)
    }
    @objc func reloadData(){
        configureWorkouts()
        configureImage()
        traningTableView.reloadData()
    }
}
    

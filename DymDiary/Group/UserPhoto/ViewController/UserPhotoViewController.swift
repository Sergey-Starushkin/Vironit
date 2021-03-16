//
//  UserPhotoViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 22.02.21.
//

import UIKit

class UserPhotoViewController: UIViewController {
    
    // - Delegate
    var delegate: UserDataDelegate?
    
    private let keychain = KeychainManager.shared
    
    // - UI
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    // - Manager
    let firebase = FirebaseDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func clickPhotoButton(_ sender: UIButton) {
        addPhoto()
    }
    @IBAction func clickCcontinueButton(_ sender: UIButton) {
        clickContinue()
    }
}
// MARK: - Action
extension UserPhotoViewController{
    func addPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    func clickContinue(){
        if userPhotoImageView.image != nil{
            firebase.upload(photo: userPhotoImageView.image!) { result in
                switch result {
                case .success:
                    self.delegate?.didTabOnContinue()
                case .failure(_):
                    self.warning(title: "Error", message: "Unable to upload photo ", completion: nil)
                }
            }
        } else {
            warning(title: "Missing photo", message: "To continue, you need to upload a photo.", completion: nil)
        }
        
    }
}
// MARK: - UIImagePickerControllerDelegate
extension UserPhotoViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        userPhotoImageView.image = image
    }
}

// MARK: - Configure
extension UserPhotoViewController {
    
    func configure() {
        userPhotoImageView.layer.cornerRadius = 150
        userPhotoImageView.clipsToBounds = true
        continueButton.layer.cornerRadius = 10
    }
}

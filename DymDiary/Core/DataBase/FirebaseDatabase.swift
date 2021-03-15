//
//  FirebaseDatabase.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 9.02.21.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

class FirebaseDatabase {
    
    private var db: Firestore!
    private let keychain = KeychainManager.shared
    
    func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let ref = Storage.storage().reference().child("avatars").child(keychain.get(key: .id))
        
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                self.keychain.save("\(url)", key: .userPhoto)
                print("URL")
                completion(.success(url))
            }
        }
    }
    
    func addUser(user: UserDataModel, completion: @escaping ((Error?) -> ())) {
        db = Firestore.firestore()
        let data: [String : Any] = [
            "name": keychain.get(key: .name),
            "age": user.age,
            "gender": user.gender.rawValue,
            "weight" : user.weignt,
            "height" : user.height,
            "id" : keychain.get(key: .id),
            "birthday" : user.birthday.timeIntervalSince1970,
            "photoUrl" : keychain.get(key: .userPhoto)
        ]
        db.collection(FirebaseCollection.userData.value).document(keychain.get(key: .id)).setData(data) { error in
            completion(error)
        }
        print("SAVE")
    }
    
    func findUser(completion: @escaping ((Bool, Error?) -> ())) {
        db = Firestore.firestore()
        let dbRef = db.collection(FirebaseCollection.userData.value).document(keychain.get(key: .id))
        dbRef.getDocument { (document, error) in
            completion(document?.exists ?? false, error)
        }
    }
    func retrieveImage( URL: String, completionBlock: @escaping (UIImage) -> Void) {
        let ref = Storage.storage().reference(forURL: URL)

        // max download size limit is 10Mb in this case
        ref.getData(maxSize: 10 * 1024 * 1024, completion: { retrievedData, error in
            if error != nil {
                // handle the error
                return
            }

            let image = UIImage(data: retrievedData!)!

            completionBlock(image)

        })
    }
    func saveTraning(id: String, mounth: String, day: String){
        db = Firestore.firestore()
        let data: [String : Any] = [
            "id": UUID().uuidString,
            "user_id": keychain.get(key: .id),
            "mounth": mounth,
            "day": day,
            "program_id": id,
        ]
        db.collection(FirebaseCollection.history.value).document(UUID().uuidString).setData(data)
    }
}
 

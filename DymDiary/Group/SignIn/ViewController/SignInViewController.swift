//
//  SignInViewController.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 1.02.21.
//

import UIKit
import FirebaseUI
import AuthenticationServices
import GoogleSignIn
import CryptoKit
 
class SignInViewController: UIViewController {
    
    // - UI
    @IBOutlet var signInButtonViewCollection: [UIView]!
    @IBOutlet weak var welcomView: UIView!
    @IBOutlet weak var appleSignInButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    // - Manager
    private let keychain = KeychainManager.shared
    private let user = FirebaseDatabase()
    
    private var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

//MARK: - Action
extension SignInViewController {
    
    @IBAction func clickAppleSignInButton(_ sender: UIButton) {
        performAppleSignIn()
    }
    @IBAction func clickGoogleSignInButton(_ sender: UIButton) {
        googleSignIn()
    }
    
    func signInWithFirebase(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            if let message = error?.localizedDescription {
                self?.warning(title: message)
            } else if let uid = Auth.auth().currentUser?.uid {
                self?.keychain.save(uid, key: .id)
                self?.keychain.save(true, key: .isAuth)
                self?.user.findUser(){ (reqest, error) in
                    if reqest == false {
                        self?.showUserDataVC()
                    }else {
                        self?.showMainVC()
                    }
                }
            }
        }
        

    }
    
    func performAppleSignIn() {
       let appleIdDetails = ASAuthorizationAppleIDProvider()
        let request = appleIdDetails.createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
        startSignInWithAppleFlow()
    }
    func googleSignIn(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
         
    }
}

//MARK: - Navigation
extension SignInViewController {
    
    func showUserDataVC() {
        let vc = UIStoryboard(storyboard: .userdata).instantiateInitialViewController() as! UserDataViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    func showMainVC() {
        let vc = UIStoryboard(storyboard: .main).instantiateInitialViewController() as! MainTabBarController
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}

// MARK: - Configure
private extension SignInViewController {
    
    func configure() {
        navigationController?.setToolbarHidden(true, animated: false)
        configureCornerRadius()
    }
    
    func configureCornerRadius() {
        welcomView.layer.cornerRadius = 30
        signInButtonViewCollection.forEach({ $0.layer.cornerRadius = 10 })
    }
    
}

// MARK: - Apple Auth
extension SignInViewController: ASAuthorizationControllerDelegate {
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    func startSignInWithAppleFlow() {
        
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }

    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
              guard let nonce = currentNonce else {
                return
              }
              guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
              }
              guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
              }
              let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                        idToken: idTokenString,
                                                        rawNonce: nonce)
            signInWithFirebase(credential: credential)
        }
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

// MARK: - Google SignIn
extension SignInViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let user = user else { return }
        print("User Email: \(user.profile.email ?? "No Email")")
        keychain.save(user.profile.name ?? "", key: .name)
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
        signInWithFirebase(credential: credential)
    }
    
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
}

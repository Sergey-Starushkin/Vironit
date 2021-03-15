//
//  AppDelegate.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 28.01.21.
//

import UIKit
import CoreData
import Firebase
import GoogleSignIn
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    var window: UIWindow?
    
    // - Manager
    private let keychain = KeychainManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

// MARK: - Configure
private extension AppDelegate {
    
    func configure() {
        configureRealm()
        FirebaseApp.configure()
        setupNavigationController()
        GIDSignIn.sharedInstance()?.clientID = "706873236729-1febao78nvaaohoe4cdckgrioqenfa00.apps.googleusercontent.com"
    }
    
    func configureRealm() {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            Realm.Configuration.defaultConfiguration = config
        }
    
    func setupNavigationController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) { self.window?.overrideUserInterfaceStyle = .light }
        let navigationController = UINavigationController()
        navigationController.viewControllers = [getMainVC()]
        navigationController.setNavigationBarHidden(true, animated: false)
        self.window!.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func getMainVC() -> UIViewController {
        if keychain.getBool(key: .isAuth) == true {
            return UIStoryboard(storyboard: .main).instantiateInitialViewController() as! MainTabBarController
        }
        return UIStoryboard(storyboard: .signIn).instantiateInitialViewController() as! SignInViewController
    }
    
}


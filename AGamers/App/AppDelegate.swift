//
//  AppDelegate.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 25.09.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = initialize()
        return true
    }
    
    func initialize() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let root = GamesListingViewController(viewModel: GamesListingViewModel(title: Constants.String.welcomeTitle))
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.navigationBar.tintColor = Theme.Color.navTintColor
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return window
    }
    
}



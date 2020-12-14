//
//  AppDelegate.swift
//  PetBreeds
//
//  Created by Mihaela Glavan on 12/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var router: Router!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let petsNavigationController = UINavigationController()
        let keyWindow = UIWindow(frame: UIScreen.main.bounds)
        keyWindow.rootViewController = petsNavigationController
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        router = Router(storyboard: storyboard, petsNavigationController: petsNavigationController)
        router.navigateToPetsViewController()
        
        keyWindow.makeKeyAndVisible()
        window = keyWindow
        return true
    }
}


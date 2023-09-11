//
//  AppDelegate.swift
//  SolarSystem_MVVM
//
//  Created by  Sergey Yurtaev on 04.09.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: PlanetsViewController())
        
        return true
    }
}




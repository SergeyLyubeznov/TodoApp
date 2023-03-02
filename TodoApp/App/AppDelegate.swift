//
//  AppDelegate.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 27.02.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = AppCoordinator.shared.window
        
        return true
    }
}

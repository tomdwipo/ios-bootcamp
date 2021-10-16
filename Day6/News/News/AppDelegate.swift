//
//  AppDelegate.swift
//  News
//
//  Created by Bayu Yasaputro on 11/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
        return true
    }


}


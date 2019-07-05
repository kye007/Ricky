//
//  AppDelegate.swift
//  Rick
//
//  Created by George Kye on 2019-07-04.
//  Copyright © 2019 georgekye. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        window?.rootViewController = UIViewController.make(fromStoryboard: .listEpisodes)
        window?.makeKeyAndVisible()

        return true
    }
}


//
//  AppDelegate.swift
//  BlueshiftSDK
//
//  Created by blueshiftcorp on 09/06/2021.
//  Copyright (c) 2021 blueshiftcorp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setInitialialViewController()
        return true
    }
    
    private func setInitialialViewController() {
        let vc = MainTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}


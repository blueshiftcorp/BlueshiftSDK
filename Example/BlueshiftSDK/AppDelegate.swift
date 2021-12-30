//
//  AppDelegate.swift
//  BlueshiftSDK
//
//  Created by blueshiftcorp on 09/06/2021.
//  Copyright (c) 2021 blueshiftcorp. All rights reserved.
//

import UIKit
import BlueshiftSDK
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var socialLogin: SocialLogin?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setInitialialViewController()
        let naverConfig = SocialLogin.NaverLoginConfig(callbackUrl: "",
                                                       clientId: "",
                                                       clientSecret: "",
                                                       appName: "")
        socialLogin = SocialLogin([.naver],
                                  naverConfig: naverConfig,
                                  kakaoAppName: "")
        socialLogin?.didFinishLaunching(application, withOptions: launchOptions)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let openUrl = socialLogin?.openUrl(app, open: url, options: options)
        if openUrl != nil {
            return openUrl!
        }
        
        return false
    }
    
    private func setInitialialViewController() {
        let vc = MainTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}


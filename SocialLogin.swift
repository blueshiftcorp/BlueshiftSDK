//
//  File name : SocialLogin.swift
//
//  Copyright (c) 2009-2021 Blueshift Corporation. All right reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Blueshift on 2021/12/30
//

import GoogleSignIn
import NaverThirdPartyLogin
import KakaoSDKAuth
import KakaoSDKCommon
import FBSDKLoginKit

public class SocialLogin {
    
    public struct NaverLoginConfig {
        let callbackUrl: String
        let clientId: String
        let clientSecret: String
        let appName: String
        
        public init(callbackUrl: String, clientId: String, clientSecret: String, appName: String) {
            self.callbackUrl = callbackUrl
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.appName = appName
        }
    }
    
    let types: [Login.LoginType]
    var naverLoginConfig: NaverLoginConfig?
    var kakaoAppName: String?
    
    public init(_ types: [Login.LoginType],
                naverConfig: NaverLoginConfig? = nil,
                kakaoAppName: String? = nil) {
        self.types = types
        self.naverLoginConfig = naverConfig
        self.kakaoAppName = kakaoAppName
    }
    
    public func didFinishLaunching(_ application: UIApplication, withOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        for type in types {
            switch type {
            case .google:   self.initGoogle()
            case .naver:    self.initNaver(naverLoginConfig)
            case .kakao:    self.initKakao(kakaoAppName)
            case .facebook: self.initFacebook(application, launchOptions)
            default: break
            }
        }
    }
    
    public func openUrl(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool? {
        
        let isGoogleLogin = GIDSignIn.sharedInstance.handle(url)
        if isGoogleLogin {
            return isGoogleLogin
        }
        
        // Naver 로그인
        NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        
        // Kakao 로그인
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        ApplicationDelegate.shared.application(app,
                                               open: url,
                                               sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                               annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        return nil
        
//        let isGoogleLogin = self.openGoogle(url: url)
//        if isGoogleLogin { return isGoogleLogin }
//
//        self.openNaver(app: app, url: url, options: options)
//
//
//        for type in types {
//            switch type {
//            case .google:   self.initGoogle()
//            case .naver:    self.initNaver(naverLoginConfig)
//            case .kakao:    self.initKakao(kakaoAppName)
//            case .facebook: self.initFacebook(application, launchOptions)
//            default: break
//            }
//        }
    }
    
    func initGoogle() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // 로그아웃 상태
            } else {
                // 로그인 상태
            }
        }
    }
    
    func initNaver(_ info: NaverLoginConfig?) {
        guard let info = info else {
            NSLog("Naver Login initialize is reqeusted but naver login config is not set.")
            return }
        let naverConnection = NaverThirdPartyLoginConnection.getSharedInstance()
        naverConnection?.isNaverAppOauthEnable = true
        naverConnection?.isInAppOauthEnable = true
        naverConnection?.isOnlyPortraitSupportedInIphone()
        naverConnection?.serviceUrlScheme = info.callbackUrl
        naverConnection?.consumerKey = info.clientId
        naverConnection?.consumerSecret = info.clientSecret
        naverConnection?.appName = info.appName
    }
    
    func initKakao(_ nativeAppKey: String?) {
        guard let nativeAppKey = nativeAppKey else {
            NSLog("Kakao Login initialize is reqeusted but Kakao native app key is not set.")
            return
        }

        KakaoSDK.initSDK(appKey: nativeAppKey)
    }
    
    func initFacebook(_ application: UIApplication?, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) {
        guard let application = application else {
            NSLog("Facebook Login initialize is reqeusted but UIApplication is not set.")
            return
        }

        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
//    public func openGoogle(url: URL) -> Bool {
//        GIDSignIn.sharedInstance.handle(url)
//    }
//    
//    public func openNaver(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
//    }
//    
//    public func openKakao() {
//        
//    }
//    
//    public func openFacebook() {
//        
//    }
    
    
}

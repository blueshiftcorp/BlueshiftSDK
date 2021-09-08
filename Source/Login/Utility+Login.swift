//
// File name : Util+SocialLogin.swift

// Copyright (c) 2009-2021 Blueshift Corporation. All right reserved.
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
//  Created Blueshift on 2021/09/07
//

import Foundation
import KakaoSDKUser
import GoogleSignIn

extension Util {
    public class Validate {
        
        public static func email(_ email: String) throws -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            guard emailPred.evaluate(with: email) else {
                throw BSError.Validation.invalidEmailFormat
            }
            return true
        }
        
        public static func password(_ pw: String) throws -> Bool {
            let regex = try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}", options: NSRegularExpression.Options())
            guard regex.firstMatch(in: pw, options: NSRegularExpression.MatchingOptions(), range:NSMakeRange(0, pw.count)) != nil else {
                throw BSError.Validation.invalidPasswordFormat
            }
            
            return true
        }
        
        public static func phoneNum(_ _num: String?) -> Bool {
            guard let num = _num, num.count == 11 else { return false }
            let regex = "^010?([0-9]{8})"

            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: _num)
        }
        
        public static func name(_ _name: String?) -> Bool {
            guard let name = _name, name.count <= 10 else { return false }
            return true
        }
    }
//    static func setUserPreference(_ user: sUser) {
////        Pref.uIdx = user.uIdx
////        Pref.loginToken = user.token
//        setCurrentUser()
//    }
//    
//    static func setCurrentUser(completion: (() -> Void)? = nil){
//        guard let uIdx = Pref.uIdx else { return }
//        guard let loginToken = Pref.loginToken else { return}
////        guard let request = API.User.get(uIdx: uIdx) else { return }
////        request.execute { (result) in
////            switch result {
////            case .success(let value):
////                CurrentUser = value.result
////                CurrentUser.uId = uIdx
////                CurrentUser.token = loginToken
////                if completion != nil {
////                    completion!()
////                }
////            case .failure(let error):
////                print("Error occurred while get user info: \(error)")
////            }
////        }
//    }
    
    static func setRootViewController() {
        
    }
    
    class func logout() {
        
        // Google Logout
        GIDSignIn.sharedInstance.signOut()
        
        // Kakao Logout
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
            } else {
                print("kakao logout success.")
            }
        }

        Pref.reset()
        
        setRootViewController()
    }
}

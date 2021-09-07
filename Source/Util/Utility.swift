//
// File name : Utility.swift
// Project name: Blueshift Common Framework
// XCode Project name : BSCommon

// Copyright (c) 2021 iChrogene, Inc. All right reserved.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Created by James, Blueshift Corporation on 2020/06/22
// Website : www.blueshift.co.kr
// Email : admin@blueshift.co.kr
//

import UIKit
import KakaoSDKUser
import GoogleSignIn
import Alamofire
import Security

class Util {
    class Validate {
        
        static func email(_ _email: String?) -> Bool {
            
            guard let email = _email, email.count > 0 else { return false }
            
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
        
        static func password(_ _pw: String?) -> Bool {
            guard let pw = _pw, pw.count > 7, pw.count < 16 else { return false }
            
            let passwordRegEx = "[a-zA-Z0-9!@#$%^&*]+"
            let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
            
            return passwordTest.evaluate(with: pw)
        }
        
        static func phoneNum(_ _num: String?) -> Bool {
            guard let num = _num, num.count == 11 else { return false }
            return true
        }
        
        static func name(_ _name: String?) -> Bool {
            guard let name = _name, name.count <= 10 else { return false }
            return true
        }
    }
    
//    class AES256 {
//        
//        private static let SECRET_KEY = CV.API.secretKey
//        private static let IV = SECRET_KEY[..<SECRET_KEY.index(SECRET_KEY.startIndex, offsetBy: 16)]
//        
//        static func encrypt(string: String) -> String {
//            guard !string.isEmpty else { return "" }
//            return try! getAESObject().encrypt(string.bytes).toBase64()
//        }
//        
//        static func decrypt(encoded: String) -> String {
//            let datas = Data(base64Encoded: encoded)
//            
//            guard datas != nil else { return "" }
//            
//            let bytes = datas!.bytes
//            let decode = try! getAESObject().decrypt(bytes)
//            
//            return String(bytes: decode, encoding: .utf8) ?? ""
//        }
//        
//        private static func getAESObject() -> AES{
//            let keyDecodes: Array<UInt8> = Array(SECRET_KEY.utf8)
//            let ivDecodes: Array<UInt8> = Array(IV.utf8)
//            let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)
//            
//            return aesObject
//        }
//        
//    }
    
    static func setRootViewController() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        appDelegate.setInitialViewController()
    }
    
    static func setUserPreference(_ user: sUser) {
//        Pref.uIdx = user.uIdx
//        Pref.loginToken = user.token
        setCurrentUser()
    }
    
    static func setCurrentUser(completion: (() -> Void)? = nil){
        guard let uIdx = Pref.uIdx else { return }
        guard let loginToken = Pref.loginToken else { return}
//        guard let request = API.User.get(uIdx: uIdx) else { return }
//        request.execute { (result) in
//            switch result {
//            case .success(let value):
//                CurrentUser = value.result
//                CurrentUser.uId = uIdx
//                CurrentUser.token = loginToken
//                if completion != nil {
//                    completion!()
//                }
//            case .failure(let error):
//                print("Error occurred while get user info: \(error)")
//            }
//        }
    }
    
//    static var uuid: String {
//        return UIDevice.current.identifierForVendor?.uuidString ?? ""
//    }
//
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
    
    static func toast(message: String, from vc: UIViewController, duration: TimeInterval? = nil) {
        let toast = ToastViewController(title: message)
        
        vc.present(toast, animated: true)
        Timer.scheduledTimer(withTimeInterval: duration ?? 2, repeats: false) { _ in
            toast.dismiss(animated: true)
        }
    }
    
    static var isHomeButton: Bool {
        
        if let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, keyWindow.safeAreaInsets.bottom > 0 {
            return false
        } else {
            return true
        }
        
        
//        if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.keyWindow, keyWindow.safeAreaInsets.bottom > 0 {
//            return false
//        }
//        return true
    }
    
    static var bottomMargin: CGFloat {
        if isHomeButton {
            return 0
        } else {
            return 20
        }
    }
    
    class Connectivity {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnected: Bool {
            return self.sharedInstance.isReachable
        }
    }
    
    class KeyChain {
        
        static let service = Bundle.main.bundleIdentifier!
        
        static func save(account: String, value: String) {
            
            let keyChainQuery: NSDictionary = [
                kSecClass : kSecClassGenericPassword,
                kSecAttrService : service,
                kSecAttrAccount : account,
                kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
            ]
            
            SecItemDelete(keyChainQuery)
            
            let status: OSStatus = SecItemAdd(keyChainQuery, nil)
            assert(status == noErr, "토큰값 저장에 실패했습니다.")
            NSLog("status = \(status)")
        }
        
        static func load(account: String) -> String? {
            
            let keyChainQuery :NSDictionary = [
                kSecClass : kSecClassGenericPassword,
                kSecAttrService : service,
                kSecAttrAccount : account,
                kSecReturnData : kCFBooleanTrue!,
                kSecMatchLimit : kSecMatchLimitOne
            ]
            
            var dataTypeRef : AnyObject?
            let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
            
            if (status == errSecSuccess) {
                let retrievedData = dataTypeRef as! Data
                let value = String(data: retrievedData, encoding: .utf8)
                return value
            }else{
                print("Nothing was retrieved from the keychain. Status code \(status)")
                return nil
            }
        }
        
        static func delete(_ service:String, account:String) {
            
            let keyChainQuery:NSDictionary = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount : account
            ]
            
            //현재 저장되어 있는 값 삭제
            let status = SecItemDelete(keyChainQuery)
            assert(status == noErr , "토큰값 삭제에 실패했습니다.")
            NSLog("status = \(status)")
            
        }
        
        static func getAuthorizationHeader() -> NSDictionary? {
                    
            if let accessToken = self.load(account: "accessToken"){
                return ["Authorization" : "Bearer \(accessToken)"]
            }else{
                return nil
            }
        }
    }
}

//
// File name : Utility.swift
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
//  Created by Blueshift on 2021/09/07
//

import UIKit

public class Util {
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
    
    public static var isHomeButton: Bool {
        
        if let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, keyWindow.safeAreaInsets.bottom > 0 {
            return false
        } else {
            return true
        }
    }
    
    public static var bottomMargin: CGFloat {
        if isHomeButton {
            return 0
        } else {
            return 20
        }
    }

    
    public class KeyChain {
        
        static let service = Bundle.main.bundleIdentifier!
        
        public static func save(account: String, value: String) {
            
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
        
        public static func load(account: String) -> String? {
            
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
        
        public static func delete(_ service:String, account:String) {
            
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
        
        public static func getAuthorizationHeader() -> NSDictionary? {
                    
            if let accessToken = self.load(account: "accessToken"){
                return ["Authorization" : "Bearer \(accessToken)"]
            }else{
                return nil
            }
        }
    }
}

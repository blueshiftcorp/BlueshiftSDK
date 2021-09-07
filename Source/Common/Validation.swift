//
//  Validation.swift
//  punkpin
//
//  Created by James on 2021/04/21.
//  Copyright © 2021 Blueshift. All rights reserved.
//

import Foundation

class Validation {
//    
//    public func nickname(_ nickname: String) throws -> Bool {
//        guard nickname.count > 0 else {
//            throw ICError.Validation.invalidNicknameFormat
//        }
//        return true
//    }
    
    public func email(_ email: String) throws -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailPred.evaluate(with: email) else {
            throw BSError.Validation.invalidEmailFormat
        }
        return true
    }
    
    public func password(_ pw: String) throws -> Bool {
        let regex = try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}", options: NSRegularExpression.Options())
        guard regex.firstMatch(in: pw, options: NSRegularExpression.MatchingOptions(), range:NSMakeRange(0, pw.count)) != nil else {
            throw BSError.Validation.invalidPasswordFormat
        }
        
        return true
//        return numberresult && isSpecial
    }
    
    public func phoneNum(_ _num: String?) -> Bool {
        guard let num = _num, num.count == 11 else { return false }
        let regex = "^010?([0-9]{8})"

        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: _num)
    }
    
    public func name(_ _name: String?) -> Bool {
        guard let name = _name, name.count <= 10 else { return false }
        return true
    }
}

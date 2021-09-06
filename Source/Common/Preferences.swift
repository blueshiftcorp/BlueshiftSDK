//
// File name : Preferences.swift
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

import Foundation

class Pref {
    
    static let prefix: String = Bundle.main.bundleIdentifier!
    static let userDefaults: UserDefaults = UserDefaults.standard
    
    static let kHasLoginKey = prefix + "kHasLoginKey"
    static let kReturened = prefix + "kReturened"
    static let kUidx = prefix + "kUidx"
    static let kLoginToken = prefix + "kLoginToken"
    static let kCompanyIdx = prefix + "kCompanyIdx"
    
    static let kAccessKey = prefix + "kAccessKey"
    static let kSecretKey = prefix + "kSecretKey"
    
    static var hasLoginKey: Bool {
        get {
            return userDefaults.bool(forKey: kHasLoginKey)
        }
        
        set(newValue) {
            userDefaults.set(newValue, forKey: kHasLoginKey)
            userDefaults.synchronize()
        }
    }
    
    static var isReturned: Bool {
        get {
            return userDefaults.bool(forKey: kReturened)
        }
        
        set(newValue) {
            userDefaults.set(newValue, forKey: kReturened)
            userDefaults.synchronize()
        }
    }
    
    static var accessKey: String? {
        get {
            return userDefaults.string(forKey: kAccessKey)
        }
        
        set(newValue) {
            if let nv: String = newValue {
                userDefaults.set(nv, forKey: kAccessKey)
            } else {
                userDefaults.removeObject(forKey: kAccessKey)
            }
            userDefaults.synchronize()
        }
    }
    
    static var secretKey: String? {
        get {
            return userDefaults.string(forKey: kSecretKey)
        }
        
        set(newValue) {
            if let nv: String = newValue {
                userDefaults.set(nv, forKey: kSecretKey)
            } else {
                userDefaults.removeObject(forKey: kSecretKey)
            }
            userDefaults.synchronize()
        }
    }
    
    static var uIdx: String? {
        get {
            return userDefaults.string(forKey: kUidx)
        }
        
        set(newValue) {
            if let nv: String = newValue {
                userDefaults.set(nv, forKey: kUidx)
            } else {
                userDefaults.removeObject(forKey: kUidx)
            }
            userDefaults.synchronize()
        }
    }
    
    static var loginToken: String? {
        get {
            return userDefaults.string(forKey: kLoginToken)
        }
        
        set(newValue) {
            if let nv: String = newValue {
                userDefaults.set(nv, forKey: kLoginToken)
            } else {
                userDefaults.removeObject(forKey: kLoginToken)
            }
            userDefaults.synchronize()
        }
    }
    
    static var cIdx: String? {
        get {
            return userDefaults.string(forKey: kCompanyIdx)
        }
        
        set(newValue) {
            if let nv: String = newValue {
                userDefaults.set(nv, forKey: kCompanyIdx)
            } else {
                userDefaults.removeObject(forKey: kCompanyIdx)
            }
            userDefaults.synchronize()
        }
    }
    
    static func reset() {
        uIdx = nil
        loginToken = nil
    }
}

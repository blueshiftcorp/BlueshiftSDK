//
//  File name : LoginViewController.swift
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
//  Created by Blueshift on 2021/12/01
//

import UIKit
import BlueshiftSDK

class LoginViewController: BSViewController {
    
    
    private func doLogin(id: String, pw: String) {
        
        let passwordConfig = Util.Validate.PasswordConfig(upperCase: true,
                                                          lowerCase: true,
                                                          number: true,
                                                          special: true,
                                                          min: 8,
                                                          max: 20)
        let valid = Util.Validate(passwordConfig)
        do {
            guard try valid.password(pw) else { return }
        } catch {
            print(error)
        }
        
        Login(from: self)
            .withNaver()
            .execute { result in
                switch result {
                case .success(let value):
                    let a = value.email
                    NSLog("값은: \(a ?? "")")
                case .failure(let error):
                    NSLog("에러발생: \(error)")
                }
            }
    }
}
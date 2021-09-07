//
//  File name : CommonValue+API.swift

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

import Foundation

extension CV {
    
    public class Url {
        #if DEBUG
        static let host = "https://dh99qhj4ry.apigw.ntruss.com/vpc-api/stage"
        #else
        static let host = "https://dh99qhj4ry.apigw.ntruss.com/vpc-api/stage"
        #endif
        
        
        class iCare {
            static let base = "/icare"
            class Signup {
                static let base = iCare.base + "/signUp"
                
                static let insert = base + "/insert"
                
                class Duplicate {
                    static private let base = Signup.base + "/dupl"
                    static let email = base + "/email"
                    static let mobile = base + "/mobile"
                }
            }
            
            class Member {
                static let base = iCare.base + "/member"
                static let info = base + "/info"
            }
        }
        
        class User {
            static private let base = host + "/user"
            static let add = base + "/add"
            static let login = base + "/login"
            static let get = base + "/get"
            static let update = base + "/update"
        }
    }
}

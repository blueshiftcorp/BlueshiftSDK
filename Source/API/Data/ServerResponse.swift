//
// File name : ServerResponse.swift

// Copyright (c) 2021 iChrogene, Inc. All right reserved.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Created by Blueshift on 2020/06/22
//

import Foundation

public class ServerResponse {
    public class User {
        
        public struct Add: Codable {
            public let uIdx: Int
            public let chkEmail: Bool
        }
        
        public struct Login: Codable {
            public let loggedin: Bool
            public let rCode: Int                  // return code
            public let result: sUser?
        }
        
        public struct Get: Codable {
            public let loggedin: Bool
            public let result: sUser
        }
        
        public struct Update:Codable {
            public let loggedin: Bool
            public let result: Int
        }
    }
    
    public class SignUp {
        public struct Duplication: Codable {
            public let RES_DTM: String
            public let RES_CD: String
            public let RESULT: String
            public let RES_MSG: String
        }
        
        public struct Insert: Codable {
            public let RES_DTM: String
            public let RES_CD: String
            public let RES_MSG: String
        }
    }
    
    public class Member {
        public struct Info: Codable {
            public let RES_DTM: String
            public let RES_CD: String
            public let INFO: sUser
            public let RESULT_CD: String
            public let RES_MSG: String
        }
    }
}

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

class ServerResponse {
    class User {
        
        struct Add: Codable {
            let uIdx: Int
            let chkEmail: Bool
        }
        
        struct Login: Codable {
            let loggedin: Bool
            let rCode: Int                  // return code
            let result: sUser?
        }
        
        struct Get: Codable {
            let loggedin: Bool
            let result: sUser
        }
        
        struct Update:Codable {
            let loggedin: Bool
            let result: Int
        }
    }
    
    class SignUp {
        struct Duplication: Codable {
            let RES_DTM: String
            let RES_CD: String
            let RESULT: String
            let RES_MSG: String
        }
        
        struct Insert: Codable {
            let RES_DTM: String
            let RES_CD: String
            let RES_MSG: String
        }
    }
    
    class Member {
        struct Info: Codable {
            let RES_DTM: String
            let RES_CD: String
            let INFO: sUser
            let RESULT_CD: String
            let RES_MSG: String
        }
    }
}

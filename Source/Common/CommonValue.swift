//
// File name : CommonValue.swift

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

var CurrentUser = sUser()

class CV {
    
    //TEST VARIABLES
    static var tIsLoggedIn = true
    
    class API {
        static let accessKey = "CB41AD65B1AE8C0D"
        static let secretKey = "D398C3682378703B9F633EC6B3CD5151"
    }
    
//    struct KeychainConfiguration {
//        static let serviceName = Bundle.main.bundleIdentifier!
//        static let accessGroup: String? = nil
//    }
    
    class SocialLogin {
        class Google {
            static let clientId = "940575350576-n0js6dc2vecls4l4mgm0j2sscr7krdvl.apps.googleusercontent.com"
        }
        
        class Naver {
            static let callbackUrl = "naverlogin"
            static let clientID = "ywmW1X3ON1USl1BWkuQZ"
            static let clientSecret = "8wbFlFujD7"
            static let appName = "iCare"
            static let openApiUrl = "https://openapi.naver.com/v1/nid/me"
        }
        
        class Kakao {
            static let nativeAppKey = "24e31ecbe00df83a77b182714604dd6a"
        }
    }
    
    class Auth {
        static let niceUrl = "https://www.icareme.kr/nice/niceStartMobile"
        static let userAgentKey = "test"
    }
    
    class Url {
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

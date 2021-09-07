//
//  File name : CommonValue+Login.swift

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
    class Login {
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
}

//
// File name : Login.swift
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
import LocalAuthentication
import PromisedFuture

public protocol LoginDelegate {
    func withIdPassword() -> Future<LoginResult, Error>
}

public struct LoginResult {
    public let userInfo: Any
    public var socialToken: String?
}

public class Login: NSObject {
    
    public var delegate: LoginDelegate?
    var completionForNaver: ((Result<NaverUserInfo, Error>) -> Void)?
    var completionForApple: ((Result<AppleUserInfo, Error>) -> Void)?
    var parentVC: UIViewController
    
    public enum LoginType: Int {
        case idpw       = 0
        case kakao      = 1
        case facebook   = 2
        case apple      = 3
        case google     = 4
        case naver      = 5
    }
    
    public init(from vc: UIViewController) {
        self.parentVC = vc
    }
    
//    public func with(_ loginType: LoginType,
//                            id: String? = nil,
//                            password: String? = nil) -> Future<LoginResult, Error>? {
//
//        switch loginType {
//        case .idpw:
//            guard let delegate = delegate else { return nil }
//            return delegate.withIdPassword()
//        case .kakao:    return self.withKakao()
//        case .facebook: return self.withGoogle()
//        case .google:   return self.withGoogle()
//        case .naver:    return self.withNaver()
//        case .apple:    return self.withApple()
//        }
//    }
}

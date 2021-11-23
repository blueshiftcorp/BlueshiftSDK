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

class Login: NSObject {
    
    internal var parentVC: UIViewController
    internal let authContext = LAContext()
    
    init(from vc: UIViewController) {
        self.parentVC = vc
    }
    
    public func with(_ loginType: LoginType, _ email: String? = nil, _ password: String? = nil) {
        
        switch loginType {
        case .email: withEmail(email, password)
        case .google: withGoogle()
        case .naver: withNaver()
        case .kakao: withKakaoTalk()
        case .apple: withApple()
        case .facebook: break
        }
    }
    
    internal func completeLogin(authCode: LoginType, userID: String, userPw: String, userInfo: UserInfo) {
        
        /// 사용자 정보를 이용하여 현재 사용자 정보저장
        /// 완료 후 프로세스 정의
        
//        switch value.responseCode {
//        case "200":
//            if value.loginFlag == "1" {
//                Util.setUserPreference(userInfo.id, userInfo.token!)
//                Util.setRootViewController()
//            } else {
//                Util.setRootViewController()
//            }
//        case "617":
//            if authCode == .email {
//                let vc = AlertViewController(message: "아이디 혹은 비밀번호가 정확하지 않습니다.")
//                self.parentVC.present(vc, animated: false)
//
//            } else {
//                let vc = AgreementViewController()
//                vc.authCode = authCode
//                vc.userId = userID
//                vc.userPw = userPw
//                vc.router = .webView(.agreeIndex)
//                vc.title = "서비스 동의"
//                vc.hidesBottomBarWhenPushed = true
//                self.parentVC.navigationController?.pushViewController(vc, animated: true)
//            }
//        default: break
//        }
    }
}

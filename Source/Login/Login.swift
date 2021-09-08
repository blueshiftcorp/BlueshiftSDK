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

protocol LoginDelegate {
    func requestToServer()
}

open class Login: NSObject {
    
    internal var parentVC: UIViewController
//    internal var _completeHandler : ((sUser)->Void)?
    
    internal let authContext = LAContext()
    
    var delegate: LoginDelegate?
    
    public init(from vc: UIViewController) {
        self.parentVC = vc
    }
    
    public func with(_ loginType: LoginType, _ email: String? = nil, _ password: String? = nil) {
        switch loginType {
        case .email: withEmail(email, password)
        case .google: withGoogle()
        case .naver: withNaver()
        case .kakaotalk: withKakaoTalk()
        case .apple: withApple()
        }
    }
    
//    internal func completeLogin(_ user: sUser) {
//
//        //TODO: Development Only
////        let _user = sUser(uIdx: "1", token: "tempToken")
//        let _user = sUser()
//
////        Util.setUserPreference(_user)
//
////        guard let name = user.uNick, name.count > 0 else {
////            let vc = GetNicknameViewController()
////            vc.modalPresentationStyle = .fullScreen
////            vc.user = user
////            parentVC.present(vc, animated: true)
////            return
////        }
//
////        Util.setRootViewController()
//    }
    
    //TODO: 로그인 정보 저장상태인 경우 실행하도록 프로세스 정의
    private func faceId() {
        authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "") { success, error in
            guard success else {
                return
            }
            guard error != nil else {
                self.parentVC.showToast(message: BSError.Login.bioAuth.localizedDescription)
                print ("*** 생체인증 중 오류가 발생했습니다. 다른 방법으로 로그인해주세요.")
                return
            }
        }
    }
}

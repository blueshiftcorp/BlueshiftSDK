//
// File name : Login+Apple.swift
// Project name: Blueshift Common Framework
// XCode Project name : BSCommon

// Copyright (c) 2021 iChrogene, Inc. All right reserved.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Created by James, Blueshift Corporation on 2021/08/17
// Website : www.blueshift.co.kr
// Email : admin@blueshift.co.kr
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

extension Login {
    
    internal func withKakaoTalk() {
        
        guard UserApi.isKakaoTalkLoginAvailable() else { return }
        
        UserApi.shared.loginWithKakaoTalk { (_oauthToken, error) in
            
            guard error == nil else {
                NSLog("Error occurred while login in using Kakaotalk: \(error!)")
                return
            }
            
            UserApi.shared.me { (_user, error) in
                guard error == nil else {
                    NSLog("Error occurred while getting Kakaotalk user info: \(error!)")
                    return
                }
                
                guard let user = _user else { return }
                guard let oauthToken = _oauthToken else { return }
                self.doLogin(user: user, token: oauthToken)
                
            }
        }
    }
    
    private func doLogin(user: User, token: OAuthToken) {
//        guard let userId = user.id else { return }
//        guard let request = API.User.login(lCode: .kakaotalk, uId: String(userId), uPw: token.accessToken) else { return }
//
//        request.execute { (result) in
//            switch result {
//            case .success(let value):
//
//            //TODO: 로그인 성공
//                switch value.rCode {
//                case 0:
//                    self.completeLogin(value.result!)
//                    return
//                default: break
//                }
//            //TODO: 회원가입 필요
//                self.doRegister(user: user, token: token)
//            case .failure(let error):
//                NSLog("Error occurred while logging in with KakaoTalk : \(error)")
//            }
//        }
    }
    
    private func doRegister(user: User, token: OAuthToken) {
        
//        guard let email = user.kakaoAccount?.email else { return }
//        guard let nickName = user.kakaoAccount?.profile?.nickname else { return }
//        guard let profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl?.absoluteString else { return }
        
//        let pUser = sUser()
//        guard let request = API.User.add(lCode: .kakaotalk, UserInfo: pUser) else { return }
//        request.execute { (result) in
//            switch result {
//            case .success(let value):
//            //TODO: 회원가입 성공
//                guard value.uIdx > 0 else {
//                    NSLog("카카오 회원가입 중 가입이 정상적으로 이루어지지 않았습니다. uIdx = 0")
//                    return
//                }
//                self.doLogin(user: user, token: token)
//            
//            case .failure(let error):
//                NSLog("카카오 회원가입 중 오류가 발생하였습니다: \(error)")
//            }
//        }
    }
    
}
